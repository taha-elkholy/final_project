import 'package:final_project/core/const/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> saveToken({required String token});

  String? getToken();

  Future<bool> deleteToken();

  Future<bool> saveUserId({required int userId});

  int? getUserId();

  Future<bool> deleteUserId();
}

@Singleton(as: AuthLocalService)
class AuthLocalServiceImpl extends AuthLocalService {
  final SharedPreferences _preferences;

  AuthLocalServiceImpl(this._preferences);

  @override
  Future<bool> deleteToken() async {
    return await _preferences.remove(tokenKey);
  }

  @override
  String? getToken() {
    return _preferences.getString(tokenKey);
  }

  @override
  Future<bool> saveToken({required String token}) async {
    return await _preferences.setString(tokenKey, token);
  }

  @override
  Future<bool> deleteUserId() async {
    return await _preferences.remove(userIdKey);
  }

  @override
  int? getUserId() {
    return _preferences.getInt(userIdKey);
  }

  @override
  Future<bool> saveUserId({required int userId}) async {
    return await _preferences.setInt(userIdKey, userId);
  }
}
