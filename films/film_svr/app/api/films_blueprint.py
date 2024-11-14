from flask import Blueprint,request
from flask import jsonify

# 引入数据库操作对象
from app.dao.FilmsDao import FilmsDao
from app.model.models import Filmtype,FilmtypeSchema
from app.model.models import Films,FilmsSchema
from app.model.models import Filmjudges
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
import datetime
from app.dao.UsersDao import UsersDao
from app.model.models import Users,UsersSchema
from app.model.models import Discuss,DiscussSchema,Discusjudges

# 创建蓝图
films_blueprint = Blueprint("films_blueprint", __name__)

# 获取所有电影类型
@films_blueprint.route('/get-filmtypes') 
def get_filmtypes():
     # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    
    # 获取所有的电影类型
    # 创建数据库操作对象
    db_op = FilmsDao()    
    # 查询电影类型，并转换为JSON格式数据
    filmtypes = db_op.getFilmtypes()
    # many=True 转换多条数据
    filmtype_Schema = FilmtypeSchema(many=True)    
    filmtypes_data = filmtype_Schema.dump(filmtypes)
    # 将转换后的JSON格式数据存储至返回结果
    result_msg["data"] = filmtypes_data
   
    # 返回操作结果
    return jsonify(result_msg)

# 按电影类型，获取推荐电影列表（首页）
@films_blueprint.route('/recommend-films/<int:num>') 
def recommend_films(num):
     # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 判断请求及参数是否正确
    if num is None: 
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)      
    # 创建数据库操作对象
    db_op = FilmsDao()    
    # 查询所有的电影类型
    filmtypes = db_op.getFilmtypes()
    # 循环取出电影类型，并查询该类型下推荐的电影列表
    # 电影推荐列表
    rd_list = []
    for filmtype in filmtypes:
        # 获取电影类型编号
        tid = filmtype.tid
        # 查询推荐的电影列表（默认6条记录）
        films = db_op.getFilmsByIndex(tid,num)
        # 判断推荐电影列表是否为空
        if len(films) !=0 :
            # 构建返回数据
            filmtype_tmp = {"tid":tid,"name":filmtype.name,"cover":filmtype.cover}
            # 添加电影列表
            # many=True 转换多条数据
            films_Schema = FilmsSchema(many=True)    
            films_data = films_Schema.dump(films)
            filmtype_tmp["films"] = films_data
            # 将构建好的推荐电影加入到返回列表中
            rd_list.append(filmtype_tmp)         
    
    # 将转换后的JSON格式数据存储至返回结果
    result_msg["data"] = rd_list   
    
    return jsonify(result_msg)


# 按关键字，搜索电影列表（搜索）
@films_blueprint.route('/seach-films',methods=["POST"]) 
def seach_films():
     # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取Json格式的请求，并解析JSON
    request_body = request.get_json()
    # 判断传入的Json数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取搜索的关键字
    keyword = request_body.get("keyword")
        
    # 进行搜索操作
    # 创建数据库操作对象
    db_op = FilmsDao()    
    # 查询电影类型
    films = db_op.seachFilmsByKeyword(keyword)
     # many=True 转换多条数据
    films_Schema = FilmsSchema(many=True)    
    films_data = films_Schema.dump(films)
    # 将转换后的JSON格式数据存储至返回结果
    result_msg["data"] = films_data
   
    # 返回操作结果
    return jsonify(result_msg)


# 获取num条评论数最多的电影列表（轮播图）
@films_blueprint.route('/seach-carousels/<int:num>') 
def seach_carousels(num):
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 判断请求及参数是否正确
    if num is None: 
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
            
    # 进行搜索操作
    # 创建数据库操作对象
    db_op = FilmsDao()    
    # 查询电影类型
    films = db_op.seachFilmsByComment(num)
     # many=True 转换多条数据
    films_Schema = FilmsSchema(many=True)    
    films_data = films_Schema.dump(films)
    # 将转换后的JSON格式数据存储至返回结果
    result_msg["data"] = films_data
   
    # 返回操作结果
    return jsonify(result_msg)

# 按电影类型，获取电影列表
@films_blueprint.route('/get-films/<int:tid>')
def get_films(tid):
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 判断请求及参数是否正确
    if tid is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 查询电影类型
    filmtype = db_op.getFilmtypeByTid(tid)
    # 查询电影列表
    films = db_op.getFilmsByTid(tid)
    # many=True 转换多条数据
    films_Schema = FilmsSchema(many=True)
    films_data = films_Schema.dump(films)
    # 构建返回数据
    filmtype_tmp = {"tid":tid,"name":filmtype.name,"cover":filmtype.cover}
    filmtype_tmp["films"] = films_data
    # 将转换后的 JSON 格式数据存储至返回结果
    result_msg["data"] = filmtype_tmp
    return jsonify(result_msg)

# 获取电影作品信息接口
@films_blueprint.route('/get-film/<int:fid>')
def getFilm(fid):
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 判断请求及参数是否正确
    if fid is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 查询电影作品信息
    film = db_op.getFilmsByFid(fid)
    # 转换 Json 数据
    films_Schema = FilmsSchema()
    films_data = films_Schema.dump(film)
    # 将转换后的 JSON 格式数据存储至返回结果
    result_msg["data"] = films_data
    # 返回操作结果
    return jsonify(result_msg)

# 评价电影作品信息接口
@films_blueprint.route('/judge-film',methods=["POST"])
@jwt_required() # 用户身份鉴权
def judgeFilm():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取 Json 格式的请求，并解析 JSON
    request_body = request.get_json()
    # 判断传入的 Json 数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取评价数据
    fid = request_body.get("fid") # 电影作品编号
    star = request_body.get("star") # 评价星级
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    jdate = datetime.datetime.now()
    # 新建评价对象
    judge = Filmjudges(fid = fid,uid = uid,rating = star,jdate = jdate)
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 评价电影作品
    flag = db_op.updateFilmRating(judge)
    if flag:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 按电影作品，获取电影评论列表
@films_blueprint.route('/get-discuss/<int:fid>')
def get_discuss(fid):
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 判断请求及参数是否正确
    if fid is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 创建数据库操作对象
    db_dis = FilmsDao()
    db_usr = UsersDao()
    # 查询电影作品的评论列表
    discuss = db_dis.getDiscussByFid(fid)
    # 循环取出电影评论，并封装评论的用户
    # 电影评论列表
    dis_list = []
    for dis in discuss:
        # 获取用户编号
        uid = dis.uid
        # 查询用户信息
        user = db_usr.getUserByUid(uid)
        # 构建返回数据
        dis_tmp = {"did":dis.did,"comment":dis.comment,"cdate":dis.cdate,
        "topcount":dis.topcount,"lowcount":dis.lowcount,"fid":dis.fid}
        # 转换数据为 Json 格式数据
        users_Schema = UsersSchema()
        users_data = users_Schema.dump(user)
        dis_tmp["user"] = users_data
        # 将构建好的电影评论列表加入返回列表中
        dis_list.append(dis_tmp)
    # 将转换后的 JSON 格式数据存储至返回结果
    result_msg["data"] = dis_list
    return jsonify(result_msg)

# 发表电影评论接口
@films_blueprint.route('/pub-discuss',methods=["POST"])
@jwt_required() # 用户身份鉴权
def pubDiscuss():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取 Json 格式的请求，并解析 JSON
    request_body = request.get_json()
    # 判断传入的 Json 数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取电影评论数据
    fid = request_body.get("fid") # 电影作品编号
    comment = request_body.get("comment") # 评论内容
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    cdate = datetime.datetime.now()
    # 新建评论对象
    discuss = Discuss(fid = fid,uid = uid,comment = comment,cdate = cdate)
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 发表电影评论
    flag = db_op.addDiscuss(discuss)
    if flag:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 评价书评接口
@films_blueprint.route('/judge-discuss',methods=["POST"])
@jwt_required() # 用户身份鉴权
def judgeDiscuss():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取 Json 格式的请求，并解析 JSON
    request_body = request.get_json()
    # 判断传入的 Json 数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取评价数据
    did = request_body.get("did") # 书评编号
    toplow = request_body.get("toplow") # 顶/踩的标志
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    jdate = datetime.datetime.now()
    # 新建评价对象
    judge = Discusjudges(did = did,uid = uid,toplow = toplow,jdate = jdate)
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 评价书评
    flag = db_op.updateDiscussTopLow(judge)
    if flag:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 获取用户的书评列表
@films_blueprint.route('/get-mydiscuss')
@jwt_required() # 用户身份鉴权
def get_mydiscuss():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    # 创建数据库操作对象
    db_op = FilmsDao()
    # 查询用户的评论列表
    discuss = db_op.getDiscussByUid(uid)
    # 循环取出电影评论，并封装电影作品
    # 电影评论列表
    dis_list = []
    for dis in discuss:
        # 获取对应的电影编号
        fid = dis.fid
        # 查询对应电影信息
        cls = db_op.getFilmsByFid(fid)
        # 构建返回数据
        dis_tmp = {"did":dis.did,
        "comment":dis.comment,
        "cdate":dis.cdate,
        "film":{"fid":cls.fid,"title":cls.title,"cover":cls.cover}
        }
        # 将构建好的电影评论列表加入返回列表中
        dis_list.append(dis_tmp)
    # 将转换后的 JSON 格式数据存储至返回结果
    result_msg["data"] = dis_list
    return jsonify(result_msg)