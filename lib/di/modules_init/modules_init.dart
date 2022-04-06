import 'package:dio/dio.dart';
import 'package:final_project/core/const/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ModulesInit {
  Dio get dio {
    return Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          responseType: ResponseType.json),
    );
  }

  @preResolve
  Future<SharedPreferences> get cacheInit async {
    return await SharedPreferences.getInstance();
  }
}
