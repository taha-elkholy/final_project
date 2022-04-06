import 'package:final_project/features/auth/data/models/user/user_model.dart';
import 'package:final_project/features/auth/domain/entities/user.dart';

extension UserMapper on UserModelData {
  User get fromModel => User(
        id: id,
        name: name,
        email: email,
      );
}
