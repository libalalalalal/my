from typing import List, Optional

from sqlalchemy import DateTime, ForeignKeyConstraint, Index, Integer, Text, text
from sqlalchemy.dialects.mysql import TEXT, VARCHAR
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
import datetime
# 导入数据库操作对象
from app import db
from app import ma

class Filmtype(db.Model):
    __tablename__ = 'filmtype'
    __table_args__ = {'comment': '电影类型表'}

    tid: Mapped[int] = mapped_column(Integer, primary_key=True, comment='类型编号')
    name: Mapped[str] = mapped_column(VARCHAR(200), comment='类型名称')
    cover: Mapped[Optional[str]] = mapped_column(VARCHAR(200), comment='类型封面')
    remark: Mapped[Optional[str]] = mapped_column(VARCHAR(500), comment='电影类型备注')

# 使用 flask-marshmallow 自动生成schema  
class FilmtypeSchema(ma.Schema):
    class Meta:
        model = Filmtype 
        # 序列化的字段
        fields = ("tid", "name", "cover", "remark")

class Users(db.Model):
    __tablename__ = 'users'
    __table_args__ = {'comment': '用户表'}

    uid: Mapped[int] = mapped_column(Integer, primary_key=True, comment='用户编号')
    uname: Mapped[str] = mapped_column(VARCHAR(100), comment='登录账号')
    upwd: Mapped[str] = mapped_column(VARCHAR(100), comment='登录密码')
    nikename: Mapped[Optional[str]] = mapped_column(VARCHAR(100), comment='昵称')
    avatar: Mapped[Optional[str]] = mapped_column(VARCHAR(200), comment='头像')
    sex: Mapped[Optional[str]] = mapped_column(VARCHAR(50), comment='性别')
    phone: Mapped[Optional[str]] = mapped_column(VARCHAR(50), comment='电话')
    remark: Mapped[Optional[str]] = mapped_column(VARCHAR(200), comment='备注')
   
# 使用 flask-marshmallow 自动生成schema  
class UsersSchema(ma.Schema):
    class Meta:
        model = Users 
        # 序列化的字段
        fields = ("uid", "uname", "upwd", "nikename", "avatar", "sex", "phone", "remark")

class Films(db.Model):
    __tablename__ = 'films'
    __table_args__ = {'comment': '电影表'}

    fid: Mapped[int] = mapped_column(Integer, primary_key=True, comment='电影编号')
    title: Mapped[str] = mapped_column(VARCHAR(200), comment='名称')
    tid: Mapped[int] = mapped_column(Integer, comment='类型编号')
    cover: Mapped[Optional[str]] = mapped_column(VARCHAR(200), comment='封面')
    year: Mapped[Optional[str]] = mapped_column(VARCHAR(50), comment='年代')
    author: Mapped[Optional[str]] = mapped_column(VARCHAR(200), comment='作者')
    present: Mapped[Optional[str]] = mapped_column(VARCHAR(100), comment='呈现形式')
    describes: Mapped[Optional[str]] = mapped_column(TEXT, comment='电影简介')
    rating: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'0'"), comment='总评级（1-5星）')
    commentscount: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'0'"), comment='评论人总数')
   
# 使用 flask-marshmallow 自动生成schema  
class FilmsSchema(ma.Schema):
    class Meta:
        model = Films 
        # 序列化的字段
        fields = ("fid", "title", "tid", "cover", "year", "author", "present", "describes", "rating", "commentscount")

class Filmjudges(db.Model):
    __tablename__ = 'filmjudges'
    __table_args__ = {'comment': '电影评价表'}
    
    cjid: Mapped[int] = mapped_column(Integer, primary_key=True, comment='评价编号')
    fid: Mapped[int] = mapped_column(Integer)
    uid: Mapped[int] = mapped_column(Integer)
    rating: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'5'"), comment='星级评价（1-5级）')
    jdate: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, comment='评价时间')
    
# 使用 flask-marshmallow 自动生成schema  
class FilmjudgesSchema(ma.Schema):
    class Meta:
        model = Filmjudges 
        # 序列化的字段
        fields = ("cjid", "fid", "uid", "rating", "jdate")


class Discuss(db.Model):
    __tablename__ = 'discuss'
    __table_args__ = {'comment': '电影评论表'}
    
    did: Mapped[int] = mapped_column(Integer, primary_key=True, comment='评论编号')
    uid: Mapped[int] = mapped_column(Integer, comment='用户编号')
    fid: Mapped[int] = mapped_column(Integer, comment='电影编号')
    comment: Mapped[Optional[str]] = mapped_column(TEXT, comment='评论内容')
    cdate: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, comment='评论时间')
    topcount: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'0'"), comment='顶的数量')
    lowcount: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'0'"), comment='踩的数量')
   
# 使用 flask-marshmallow 自动生成schema  
class DiscussSchema(ma.Schema):
    class Meta:
        model = Discuss 
        # 序列化的字段
        fields = ("did", "uid", "fid", "comment", "cdate", "topcount", "lowcount")

class Discusjudges(db.Model):
    __tablename__ = 'discusjudges'
    __table_args__ ={'comment': '评论评价表'}

    djid: Mapped[int] = mapped_column(Integer, primary_key=True, comment='评价编号')
    uid: Mapped[int] = mapped_column(Integer, comment='用户编号')
    did: Mapped[int] = mapped_column(Integer, comment='评论编号')
    toplow: Mapped[Optional[int]] = mapped_column(Integer, server_default=text("'0'"), comment='评价标志（0-踩，1-顶）')
    jdate: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, comment='评价时间')

# 使用 flask-marshmallow 自动生成schema  
class DiscusjudgesSchema(ma.Schema):
    class Meta:
        model = Discusjudges 
        # 序列化的字段
        fields = ("djid", "uid", "did", "toplow", "jdate")

