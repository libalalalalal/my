# 引入应用工厂函数
from app import create_app
from app.api.user_blueprint import user_blueprint
from app.api.films_blueprint import films_blueprint
from app.api.image_blueprint import image_blueprint

# 调用工厂，创建app
app = create_app()
# 注册蓝图
app.register_blueprint(user_blueprint,url_prefix="/api/user")  
app.register_blueprint(films_blueprint,url_prefix="/api/films") 
app.register_blueprint(image_blueprint,url_prefix="/api/image")      
# 启动Flask程序
if __name__ == "__main__":
    # 启动服务，设置主机和端口
    app.run(host="0.0.0.0", port=5000, debug=True)