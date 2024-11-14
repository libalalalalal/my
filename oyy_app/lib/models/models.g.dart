// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      userId: (json['user_id'] as num).toInt(),
      mobile: json['mobile'] as String,
      nickName: json['nick_name'] as String,
      avatarId: (json['avatar_id'] as num).toInt(),
      gender: json['gender'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      addressId: (json['address_id'] as num).toInt(),
      balance: json['balance'] as String,
      points: (json['points'] as num).toInt(),
      payMoney: json['pay_money'] as String,
      expendMoney: json['expend_money'] as String,
      gradeId: (json['grade_id'] as num).toInt(),
      platform: json['platform'] as String,
      lastLoginTime: (json['last_login_time'] as num).toInt(),
      avatar: Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      grade: Grade.fromJson(json['grade'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'user_id': instance.userId,
      'mobile': instance.mobile,
      'nick_name': instance.nickName,
      'avatar_id': instance.avatarId,
      'gender': instance.gender,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'address_id': instance.addressId,
      'balance': instance.balance,
      'points': instance.points,
      'pay_money': instance.payMoney,
      'expend_money': instance.expendMoney,
      'grade_id': instance.gradeId,
      'platform': instance.platform,
      'last_login_time': instance.lastLoginTime,
      'avatar': instance.avatar,
      'grade': instance.grade,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      fileId: (json['file_id'] as num).toInt(),
      groupId: (json['group_id'] as num).toInt(),
      channel: (json['channel'] as num).toInt(),
      storage: json['storage'] as String,
      domain: json['domain'] as String,
      fileType: (json['file_type'] as num).toInt(),
      fileName: json['file_name'] as String,
      filePath: json['file_path'] as String,
      fileSize: (json['file_size'] as num).toInt(),
      fileExt: json['file_ext'] as String,
      cover: json['cover'] as String,
      uploaderId: (json['uploader_id'] as num).toInt(),
      isRecycle: (json['is_recycle'] as num).toInt(),
      isDelete: (json['is_delete'] as num).toInt(),
      updateTime: json['update_time'] as String,
      previewUrl: json['preview_url'] as String,
      externalUrl: json['external_url'] as String,
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'file_id': instance.fileId,
      'group_id': instance.groupId,
      'channel': instance.channel,
      'storage': instance.storage,
      'domain': instance.domain,
      'file_type': instance.fileType,
      'file_name': instance.fileName,
      'file_path': instance.filePath,
      'file_size': instance.fileSize,
      'file_ext': instance.fileExt,
      'cover': instance.cover,
      'uploader_id': instance.uploaderId,
      'is_recycle': instance.isRecycle,
      'is_delete': instance.isDelete,
      'update_time': instance.updateTime,
      'preview_url': instance.previewUrl,
      'external_url': instance.externalUrl,
    };

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      gradeId: (json['grade_id'] as num).toInt(),
      name: json['name'] as String,
      weight: (json['weight'] as num).toInt(),
      upgrade: Upgrade.fromJson(json['upgrade'] as Map<String, dynamic>),
      equity: Equity.fromJson(json['equity'] as Map<String, dynamic>),
      status: (json['status'] as num).toInt(),
      isDelete: (json['is_delete'] as num).toInt(),
      storeId: (json['store_id'] as num).toInt(),
      createTime: json['create_time'] as String,
      updateTime: json['update_time'] as String,
    );

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'grade_id': instance.gradeId,
      'name': instance.name,
      'weight': instance.weight,
      'upgrade': instance.upgrade,
      'equity': instance.equity,
      'status': instance.status,
      'is_delete': instance.isDelete,
      'store_id': instance.storeId,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
    };

Upgrade _$UpgradeFromJson(Map<String, dynamic> json) => Upgrade(
      expendMoney: json['expend_money'] as String,
    );

Map<String, dynamic> _$UpgradeToJson(Upgrade instance) => <String, dynamic>{
      'expend_money': instance.expendMoney,
    };

Equity _$EquityFromJson(Map<String, dynamic> json) => Equity(
      discount: json['discount'] as String,
    );

Map<String, dynamic> _$EquityToJson(Equity instance) => <String, dynamic>{
      'discount': instance.discount,
    };
