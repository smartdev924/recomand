import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  // String name;
  // String job;
  int? id;
  String? createdAt;
  String? email;
  String? updatedAt;
  String? tz;
  String? fullName;
  File? avatar;
  File? account_header;

  UserInfo({
    // required this.name,
    // required this.job,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.tz,
    this.fullName
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
