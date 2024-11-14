from flask import Blueprint,request
from flask import jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity

# 引入数据库操作对象
from app.dao.UsersDao import UsersDao
from app.model.models import Users,UsersSchema

import os
import uuid
# 导入上传头像的配置(头像路径，图片扩展名的集合)
from app.conf.config import ALLOWED_EXTENSIONS,IMAGE_HEAD_PATH
from werkzeug.utils import secure_filename

# 创建蓝图
user_blueprint = Blueprint("user_blueprint", __name__)
# 用户注册接口
@user_blueprint.route('/register',methods=["POST"]) 
def register():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取Json格式的请求，并解析JSON
    request_body = request.get_json()
    # 判断传入的Json数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取注册数据
    uname = request_body.get("uname") # 登录账号
    upwd = request_body.get("upwd") # 登录密码
    nikename = request_body.get("nikename") # 昵称
    avatar = request_body.get("avatar") # 头像
    sex = request_body.get("sex") # 性别
    phone = request_body.get("phone") # 电话
    # 注册用户
    # 创建数据库操作对象
    db_op = UsersDao()
    # 新建用户对象对象
    user = Users(uname=uname,upwd=upwd,nikename=nikename,avatar=avatar,sex=sex,phone=phone)
    # 增加用户
    flag = db_op.addUser(user)
    
    if flag:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 用户登录接口
@user_blueprint.route('/login',methods=["POST"]) 
def login():
     # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取Json格式的请求，并解析JSON
    request_body = request.get_json()
    
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    
    # 获取登录数据
    uname = request_body.get("uname") # 登录账号
    upwd = request_body.get("upwd") # 登录密码    
    # 登录操作
    # 创建数据库操作对象
    db_op = UsersDao()    
    # 进行登录操作
    user = db_op.getUserByLogin(uname,upwd)
    # 判断是否登录成功
    if user is not None:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
        # 创建JWT并返回  
        access_token = create_access_token(identity=user.uid) 
        result_msg["token"] = access_token
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 获取用户信息接口
@user_blueprint.route('/get-user')
@jwt_required() # 用户身份鉴权
def getUser():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    # 创建数据库操作对象
    db_op = UsersDao()
    # 进行登录操作
    user = db_op.getUserByUid(uid)
    # 判断是否登录成功
    if user is not None:        
        # 转换数据为 Json 格式数据
        users_Schema = UsersSchema()
        users_data = users_Schema.dump(user)
        result_msg["data"] = users_data
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 判断头像图片是否允许上传
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
# 上传用户头像
@user_blueprint.route("/upload", methods=["POST"])
def upload():
    # 返回信息
    result_msg = {"code": "200", "msg": "上传成功！"}
    # 判断是否有上传文件
    if 'file' not in request.files:
        result_msg["code"] = "404"
        result_msg["msg"] = "文件不存在！"
        return jsonify(result_msg)
    # 获取上传文件
    upfile = request.files['file']
    # 判断是否允许上传
    if upfile and allowed_file(upfile.filename):
        # 获取文件名称
        upname = secure_filename(upfile.filename)
        # upname = upfile.filename
        # 处理重名情况，因此使用 uuid 生成文件名
        fname = str(uuid.uuid4()) + '.' + upname.rsplit('.', 1)[1]
        # 保存文件到上传目录
        upfile.save(os.path.join(IMAGE_HEAD_PATH, fname))
        result_msg["upFile"] = fname
    else:
        # 构建返回的 Json 数据
        result_msg["code"] = "400"
        result_msg["msg"] = "上传失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 修改用户信息接口
@user_blueprint.route('/update-user', methods=["POST"])
@jwt_required() # 用户身份鉴权
def updateUser():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取 Json 格式的请求，并解析 JSON
    request_body = request.get_json()
    # 判断传入的 Json 数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取参数
    nikename = request_body.get("nikename")
    avatar = request_body.get("avatar")
    sex = request_body.get("sex")
    phone = request_body.get("phone")
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    # 创建数据库操作对象
    db_op = UsersDao()
    # 新建用户对象
    user = Users(uid = uid,nikename = nikename,sex = sex,phone = phone,avatar = avatar)
    # 修改用户信息
    flag = db_op.updateUserBySelf(user)
    if flag:
        result_msg["code"] = "200"
        result_msg["msg"] = "操作成功！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "操作失败！"
    # 返回操作结果
    return jsonify(result_msg)

# 修改用户密码接口
@user_blueprint.route('/update-pwd', methods=["POST"])
@jwt_required() # 用户身份鉴权
def updatePwd():
    # 返回信息
    result_msg = {"code": "200", "msg": "操作成功！"}
    # 获取 Json 格式的请求，并解析 JSON
    request_body = request.get_json()
    # 判断传入的 Json 数据是否为空
    if request.get_json() is None:
        result_msg["code"] = "404"
        result_msg["msg"] = "参数错误"
        return jsonify(result_msg)
    # 获取参数
    oldpwd = request_body.get("oldpwd")
    newpwd = request_body.get("newpwd")
    # 获取认证的用户编号(登录时，通过 uid 生成 Token)
    uid = get_jwt_identity()
    # 创建数据库操作对象
    db_op = UsersDao()
    # 查询用户信息
    user = db_op.getUserByUid(uid)
    # 判断旧密码是否正确
    if user.upwd == oldpwd:
        # 修改用户信息
        flag = db_op.updateUserByPwd(uid,newpwd)
        if flag:
            result_msg["code"] = "200"
            result_msg["msg"] = "修改成功！"
        else:
            result_msg["code"] = "404"
            result_msg["msg"] = "操作失败！"
    else:
        result_msg["code"] = "404"
        result_msg["msg"] = "旧密码不正确"
    # 返回操作结果
    return jsonify(result_msg)

# 路由保护，该路由需要认证用户才能访问
# 注意：请求时，headers需要携带Authorization参数，其值为Bearer+空格 +token的字符串。
@user_blueprint.route('/protected', methods=['GET'])  
@jwt_required()  
def protected():  
    current_user = get_jwt_identity()  # 获取认证的用户  
    return jsonify(logged_in_as=current_user), 200

# # 测试
# @user_blueprint.route('/test',methods=["POST"]) 
# def test():
#     # 返回信息
#     result_msg = {"code": "200", "msg": "操作成功！"}
#     # 根据uid查询  返回模型对象/None
#     classics = Classics.query.all()
#     classicsSchema = ClassicsSchema(many=True)
#     # 将用户类别转换为JSON数据列表
#     classics_json = classicsSchema.dump(classics)
        
#     return jsonify(classics_json)