// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _JobsService implements JobsService {
  _JobsService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<JobsModel> getJobs({required token}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<JobsModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'jobs',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = JobsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<String>> applyForJob(
      {required token,
      required userId,
      required jobId,
      required currentSalary,
      required expectedSalary,
      required cv}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('Authorization', token));
    _data.fields.add(MapEntry('user_id', userId.toString()));
    _data.fields.add(MapEntry('job_id', jobId.toString()));
    _data.fields.add(MapEntry('current_salary', currentSalary.toString()));
    _data.fields.add(MapEntry('expected_salary', expectedSalary.toString()));
    _data.files.add(MapEntry(
        'cv',
        MultipartFile.fromFileSync(cv.path,
            filename: cv.path.split(Platform.pathSeparator).last)));
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<String>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'appliedJob',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<String>();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
