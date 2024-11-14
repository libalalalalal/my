from flask import Blueprint,request,make_response
import os
# 导入图片路径
from app.conf.config import IMAGE_CLS_PATH,IMAGE_HEAD_PATH

# 创建蓝图
image_blueprint = Blueprint("image_blueprint", __name__)

# 项目示图片显示接口(type：fil-电影封面图片，head-用户头像图片)
@image_blueprint.route('/display/<string:type>/<string:filename>')
def display(type, filename):   
    # 判断请求及参数是否正确
    if filename is not None and type is not None:  
        # 判断图片类型，并构建图片路径   
        if type =="fil":
            img_path = os.path.join(IMAGE_CLS_PATH, filename)
        else:
            img_path = os.path.join(IMAGE_HEAD_PATH, filename)            
        # 判断图片是否存在，并返回图片流
        if not os.path.isfile(img_path):
            pass
        else:                    
            image_data = open(img_path, "rb").read()
            response = make_response(image_data)
            response.headers['Content-Type'] = 'image/jpg'
            return response
    else:
        pass