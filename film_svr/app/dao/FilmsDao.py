from app import db
from app.model.models import Filmtype,Films
from app.model.models import Discuss

# 数据库操作类
class FilmsDao:
    def __init__(self):
        print("FilmsDao is runing")
        
    # 1.获取电影类型列表
    def getFilmtypes(self):        
        try:
            # 获取所有电影类型   
            filmtypes = Filmtype.query.all()           
            return filmtypes
        except Exception as e:
            print(e)           
            pass
    # 2.获取电影列表(首页推荐使用)
    def getFilmsByIndex(self,tid,num):        
        try:
            # 排序查询:所有电影类型按星级评价从高到低排序, 取前5个   
            films = Films.query.filter(Films.tid==tid).order_by(Films.rating.desc()).limit(num).all() 
            return films
        except Exception as e:
            print(e)           
            pass
    # 3.搜索电影列表(按电影标题搜索)
    def seachFilmsByKeyword(self,keyword):        
        try:
            # 按电影标题进行d模糊查询   
            films = Films.query.filter(Films.title.contains(keyword)).all() 
            return films
        except Exception as e:
            print(e)           
            pass
    # 4.获取电影列表(按评论数搜索)
    def seachFilmsByComment(self,num):        
        try:
            # 排序查询:按电影评论数从大到小排序, 取前num个    
            films = Films.query.order_by(Films.commentscount.desc()).limit(num).all() 
            return films
        except Exception as e:
            print(e)           
            pass
        
    # 5.获取电影类型
    def getFilmtypeByTid(self,tid):
        try:
            # 排序查询:按星级评价从高到低排序
            filmtype = Filmtype.query.get(tid)
            return filmtype
        except Exception as e:
            print(e)
            pass
    # 6.获取某电影类型下的电影列表
    def getFilmsByTid(self,tid):
        try:
            # 排序查询:按星级评价从高到低排序
            films = Films.query.filter(Films.tid==tid).order_by(Films.rating.desc()).all()
            return films
        except Exception as e:
            print(e)
            pass
        
    # 7.获取电影作品
    def getFilmsByFid(self,fid):
        try:
            # 查询
            film = Films.query.get(fid)
            return film
        except Exception as e:
            print(e)
            pass
    # 8.评价电影作品
    def updateFilmRating(self,judge):
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            # 查询电影作品
            film = Films.query.get(judge.fid)
            # 设置电影作品评价星级(取最高评价)
            film.rating = max(judge.rating,film.rating)
            # 将评价信息插入电影评价表
            db.session.add(judge)
            db.session.commit() # 提交至数据库
        except Exception as e:
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass
        return flag
    
    # 9.获取某电影作品的评论列表
    def getDiscussByFid(self,fid):
        try:
            # 排序查询:按评论时间从高到低排序
            discuss = Discuss.query.filter(Discuss.fid==fid).order_by(Discuss.cdate.desc()).all()
            return discuss
        except Exception as e:
            print(e)
            pass
        
    # 10.发表电影评论
    def addDiscuss(self,discuss):
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            # 查询对应的电影作品
            film = Films.query.get(discuss.fid)
            # 设置电影作品的评论数(+1)
            film.commentscount = film.commentscount+1
            # 将评论插入电影评论表
            db.session.add(discuss)
            db.session.commit() # 提交至数据库
        except Exception as e:
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass
        return flag
    
    # 11.评价书评
    def updateDiscussTopLow(self,judge):
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            # 查询书评信息
            dis = Discuss.query.get(judge.did)
            # 设置书评的“顶”和“踩”的数量
            if judge.toplow==1:
                dis.topcount = dis.topcount+1
            else:
                dis.lowcount = dis.lowcount+1
            # 将评价信息插入书评评价表
            db.session.add(judge)
            db.session.commit() # 提交至数据库
        except Exception as e:
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass
        return flag
    
    # 12.获取用户的书评列表
    def getDiscussByUid(self,uid):
        try:
            # 排序查询:按评论时间从高到低排序
            discuss = Discuss.query.filter(Discuss.uid==uid).order_by(Discuss.cdate.desc()).all()
            return discuss
        except Exception as e:
            print(e)
            pass