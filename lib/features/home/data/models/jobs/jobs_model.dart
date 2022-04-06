import 'package:json_annotation/json_annotation.dart';

part 'jobs_model.g.dart';

@JsonSerializable()
class JobsModel {
  @JsonKey(name: 'data')
  List<JobData>? data;
  @JsonKey(name: 'Message')
  String? message;

  JobsModel({
    this.data,
    this.message,
  });

  factory JobsModel.fromJson(Map<String, dynamic> json) =>
      _$JobsModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobsModelToJson(this);
}

@JsonSerializable()
class JobData {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'JobName')
  String? jobName;
  @JsonKey(name: 'Description')
  String? description;
  @JsonKey(name: 'Published Date')
  String? publishedDate;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;

  JobData(
      {required this.id,
      this.jobName,
      this.description,
      this.publishedDate,
      this.updatedAt,
      this.createdAt});

  factory JobData.fromJson(Map<String, dynamic> json) =>
      _$JobDataFromJson(json);

  Map<String, dynamic> toJson() => _$JobDataToJson(this);
}
