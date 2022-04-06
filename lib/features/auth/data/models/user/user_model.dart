import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'user')
  UserModelData user;
  @JsonKey(name: 'token')
  String token;

  UserModel({
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserModelData {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'created_at')
  String createdAt;

  UserModelData({
    required this.id,
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserModelData.fromJson(Map<String, dynamic> json) =>
      _$UserModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelDataToJson(this);
}
