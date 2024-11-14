from app import db
from app.model.models import Users

# 数据库操作类
class UsersDao:
    def __init__(self):
        print("userdao is runing")
        
    # 1.增加一个用户
    def addUser(self,user):        
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            db.session.add(user)
            db.session.commit() # 提交至数据库
        except Exception as e:            
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass        
        return flag
    
    # 2.通过账号及密码查询用户
    def getUserByLogin(self,uname,upwd):        
        try:
            # 查询
            user = Users.query.filter(Users.uname == uname,Users.upwd == upwd).first()            
            return user  
        except Exception as e:
            print(e)           
            pass
        
    # 3.通过用户编号查询用户
    def getUserByUid(self,uid):
        try:
            # 查询
            user = Users.query.get(uid)
            return user
        except Exception as e:
            print(e)
        pass
    
    # 4.修改用户资料
    def updateUserBySelf(self,user):
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            # 查询用户
            user_tmp = Users.query.get(user.uid)
            # 设置用户修改的字段
            user_tmp.nikename = user.nikename
            user_tmp.avatar = user.avatar
            user_tmp.sex = user.sex
            user_tmp.phone = user.phone
            db.session.commit() # 提交至数据库
        except Exception as e:
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass
        return flag
    
    # 5.修改用户密码
    def updateUserByPwd(self,uid,new_pwd):
        flag = True # 成功标志，True 操作成功，False 操作失败
        try:
            # 查询用户
            user_tmp = Users.query.get(uid)
            # 设置用户修改的字段
            user_tmp.upwd = new_pwd
            db.session.commit() # 提交至数据库
        except Exception as e:
            flag = False
            db.session.rollback() # 异常，回滚数据库
            pass
        return flag