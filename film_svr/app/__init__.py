from flask import Flask

from flask_jwt_extended import JWTManager
from datetime import timedelta
from app.conf.config import JWT_SECRET_KEY
from app.conf.config import JWT_ACCESS_TOKEN_EXPIRES
from app.conf.config import ENSURE_ASCII
from flask_cors import CORS 
from app.conf.dbconfig import SQLALCHEMY_DATABASE_URI
from app.conf.dbconfig import SQLALCHEMY_ECHO
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow


jwt = JWTManager()  # 初始化 JWTManager 

db = SQLAlchemy()   # 创建数据库的操作对象
ma = Marshmallow()  # 初始化 Marshmallow

def create_app():
    # 构建app
    app = Flask(__name__)  
      
    app.json.ensure_ascii = ENSURE_ASCII # 解决中文乱码问题
    CORS(app, resources=r'/*')  # 允许所有资源跨域  

    # 设置JWT的密钥   
    app.config['JWT_SECRET_KEY'] = JWT_SECRET_KEY  
    # 设置访问令牌的过期时间  
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=JWT_ACCESS_TOKEN_EXPIRES)  
    jwt.init_app(app)   # JWTManager 初始化app
    
    # 载入数据库配置
    # app.config.from_object('app.conf.dbconfig')
    app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
    app.config['SQLALCHEMY_ECHO'] = SQLALCHEMY_ECHO 
    # 数据库操作对象绑定app    
    db.init_app(app)
    ma.init_app(app)
        	
    return app