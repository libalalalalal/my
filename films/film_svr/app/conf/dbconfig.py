# ------ MySQL数据库配置 ------
# MySql连接的URI
SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:root@127.0.0.1:3306/filmsdb?charset=utf8'
#  记录所有发送到标准输出的SQL语句，通常在开发调试时很有帮助。
SQLALCHEMY_ECHO = True
