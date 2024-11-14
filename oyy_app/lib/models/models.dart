import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'user_id')
  final int userId;
  final String mobile;
  @JsonKey(name: 'nick_name')
  final String nickName;
  @JsonKey(name: 'avatar_id')
  final int avatarId;
  final String gender;
  final String country;
  final String province;
  final String city;
  @JsonKey(name: 'address_id')
  final int addressId;
  final String balance;
  final int points;
  @JsonKey(name: 'pay_money')
  final String payMoney;
  @JsonKey(name: 'expend_money')
  final String expendMoney;
  @JsonKey(name: 'grade_id')
  final int gradeId;
  final String platform;
  @JsonKey(name: 'last_login_time')
  final int lastLoginTime;
  final Avatar avatar;
  final Grade grade;

  UserInfo({
    required this.userId,
    required this.mobile,
    required this.nickName,
    required this.avatarId,
    required this.gender,
    required this.country,
    required this.province,
    required this.city,
    required this.addressId,
    required this.balance,
    required this.points,
    required this.payMoney,
    required this.expendMoney,
    required this.gradeId,
    required this.platform,
    required this.lastLoginTime,
    required this.avatar,
    required this.grade,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Avatar {
  @JsonKey(name: 'file_id')
  final int fileId;
  @JsonKey(name: 'group_id')
  final int groupId;
  final int channel;
  final String storage;
  final String domain;
  @JsonKey(name: 'file_type')
  final int fileType;
  @JsonKey(name: 'file_name')
  final String fileName;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'file_size')
  final int fileSize;
  @JsonKey(name: 'file_ext')
  final String fileExt;
  final String cover;
  @JsonKey(name: 'uploader_id')
  final int uploaderId;
  @JsonKey(name: 'is_recycle')
  final int isRecycle;
  @JsonKey(name: 'is_delete')
  final int isDelete;
  @JsonKey(name: 'update_time')
  final String updateTime;
  @JsonKey(name: 'preview_url')
  final String previewUrl;
  @JsonKey(name: 'external_url')
  final String externalUrl;

  Avatar({
    required this.fileId,
    required this.groupId,
    required this.channel,
    required this.storage,
    required this.domain,
    required this.fileType,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.fileExt,
    required this.cover,
    required this.uploaderId,
    required this.isRecycle,
    required this.isDelete,
    required this.updateTime,
    required this.previewUrl,
    required this.externalUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class Grade {
  @JsonKey(name: 'grade_id')
  final int gradeId;
  final String name;
  final int weight;
  final Upgrade upgrade;
  final Equity equity;
  final int status;
  @JsonKey(name: 'is_delete')
  final int isDelete;
  @JsonKey(name: 'store_id')
  final int storeId;
  @JsonKey(name: 'create_time')
  final String createTime;
  @JsonKey(name: 'update_time')
  final String updateTime;

  Grade({
    required this.gradeId,
    required this.name,
    required this.weight,
    required this.upgrade,
    required this.equity,
    required this.status,
    required this.isDelete,
    required this.storeId,
    required this.createTime,
    required this.updateTime,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);
  Map<String, dynamic> toJson() => _$GradeToJson(this);
}

@JsonSerializable()
class Upgrade {
  @JsonKey(name: 'expend_money')
  final String expendMoney;

  Upgrade({
    required this.expendMoney,
  });

  factory Upgrade.fromJson(Map<String, dynamic> json) =>
      _$UpgradeFromJson(json);
  Map<String, dynamic> toJson() => _$UpgradeToJson(this);
}

@JsonSerializable()
class Equity {
  final String discount;

  Equity({
    required this.discount,
  });

  factory Equity.fromJson(Map<String, dynamic> json) => _$EquityFromJson(json);
  Map<String, dynamic> toJson() => _$EquityToJson(this);
}
