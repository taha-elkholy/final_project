import 'package:final_project/core/app_use_case/app_use_case.dart';
import 'package:final_project/features/auth/domain/entities/login_param.dart';
import 'package:final_project/features/auth/domain/entities/register_param.dart';
import 'package:final_project/features/auth/domain/use_case/get_token_use_case.dart';
import 'package:final_project/features/auth/domain/use_case/login_use_case.dart';
import 'package:final_project/features/auth/domain/use_case/logout_use_case.dart';
import 'package:final_project/features/auth/domain/use_case/register_use_case.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._registerUseCase,
    this._getTokenUseCase,
  ) : super(const AuthInitialState());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final GetTokenUseCase _getTokenUseCase;

  Future<void> getHomeScreen() async {
    emit(const StartupLoadingState());

    final result = await _getTokenUseCase(NoParams());
    emit(result.fold((error) => StartupErrorState(error: error.message),
        (token) => const StartupLoadedState()));
  }

  Future<void> register({required RegisterParam registerParam}) async {
    emit(const RegisterLoadingState());
    final result = await _registerUseCase(registerParam);
    emit(result.fold((error) => RegisterErrorState(error: error.message),
        (user) => const RegisterLoadedState()));
  }

  Future<void> login({required LoginParam loginParam}) async {
    emit(const LoginLoadingState());
    final result = await _loginUseCase(loginParam);
    emit(result.fold((error) => LoginErrorState(error: error.message),
        (user) => const LoginLoadedState()));
  }

  Future<void> logout() async {
    emit(const LogoutLoadingState());
    final result = await _logoutUseCase(NoParams());
    emit(result.fold((error) {
      debugPrint(error.message);

      return LogoutErrorState(error: error.message);
    }, (done) {
      return const LogoutLoadedState();
    }));
  }
}
