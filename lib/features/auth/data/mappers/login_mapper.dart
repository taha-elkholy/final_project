import 'package:final_project/features/auth/data/models/login/login_model.dart';
import 'package:final_project/features/auth/domain/entities/login_param.dart';

extension LoginMapper on LoginParam {
  LoginModel get toModel => LoginModel(
        email: email,
        password: password,
      );
}
