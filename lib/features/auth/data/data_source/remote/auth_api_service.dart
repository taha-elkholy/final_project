import 'package:dio/dio.dart';
import 'package:final_project/core/const/constants.dart';
import 'package:final_project/features/auth/data/models/login/login_model.dart';
import 'package:final_project/features/auth/data/models/register/register_model.dart';
import 'package:final_project/features/auth/data/models/user/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service.g.dart';

@singleton
@RestApi(baseUrl: baseUrl)
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(registerEndPoint)
  Future<UserModel> register(
      {@Body() required RegisterModel registerSentData});

  @POST(loginEndPoint)
  Future<UserModel> login({@Body() required LoginModel loginSentData});

  @POST(logoutEndPoint)
  Future<String> logout({@Header(authorizationHeader) required String token});
}
