// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobsModel _$JobsModelFromJson(Map<String, dynamic> json) => JobsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => JobData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['Message'] as String?,
    );

Map<String, dynamic> _$JobsModelToJson(JobsModel instance) => <String, dynamic>{
      'data': instance.data,
      'Message': instance.message,
    };

JobData _$JobDataFromJson(Map<String, dynamic> json) => JobData(
      id: json['id'] as int,
      jobName: json['JobName'] as String?,
      description: json['Description'] as String?,
      publishedDate: json['Published Date'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$JobDataToJson(JobData instance) => <String, dynamic>{
      'id': instance.id,
      'JobName': instance.jobName,
      'Description': instance.description,
      'Published Date': instance.publishedDate,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
    };
