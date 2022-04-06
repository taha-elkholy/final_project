// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      user: UserModelData.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

UserModelData _$UserModelDataFromJson(Map<String, dynamic> json) =>
    UserModelData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$UserModelDataToJson(UserModelData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
    };
