# 项目常用配置
# ------ JSON编码配置 ------
ENSURE_ASCII = False  # 设置是否对JSON数据进行ascii编码
# ------JWT配置------
JWT_SECRET_KEY = 'jwt_xiaobai_168'  # 设置JWT的密钥
# 设置访问令牌的过期时间,默认15分钟
JWT_ACCESS_TOKEN_EXPIRES = 15 
# ------图片路径配置------
# 文学封面路径
IMAGE_CLS_PATH = r'C:/fil_image/fil'
# 用户头像路径
IMAGE_HEAD_PATH = r'C:/fil_image/head'
# 上传文件时，允许的头像图片扩展名的集合
ALLOWED_EXTENSIONS = set(['png', 'gif', 'jpg', 'webp', 'jpeg'])