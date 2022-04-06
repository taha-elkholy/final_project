import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_states.freezed.dart';

@freezed
class AuthStates with _$AuthStates {
  const factory AuthStates.initial() = AuthInitialState;

  // startup
  const factory AuthStates.startupLoading() = StartupLoadingState;

  const factory AuthStates.startupLoaded() =
      StartupLoadedState;

  const factory AuthStates.startupError({required String error}) =
      StartupErrorState;

  // login states
  const factory AuthStates.loginLoading() = LoginLoadingState;

  const factory AuthStates.loginLoaded() = LoginLoadedState;

  const factory AuthStates.loginError({required String error}) =
      LoginErrorState;

  // register states
  const factory AuthStates.registerLoading() = RegisterLoadingState;

  const factory AuthStates.registerLoaded() = RegisterLoadedState;

  const factory AuthStates.registerError({required String error}) =
      RegisterErrorState;

  // logout states
  const factory AuthStates.logoutLoading() = LogoutLoadingState;

  const factory AuthStates.logoutLoaded() = LogoutLoadedState;

  const factory AuthStates.logoutError({required String error}) =
      LogoutErrorState;
}
