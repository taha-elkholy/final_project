// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../../features/auth/data/data_source/local/auth_local_service.dart'
    as _i7;
import '../../features/auth/data/data_source/remote/auth_api_service.dart'
    as _i6;
import '../../features/auth/data/repository/auth_repo_impl.dart' as _i9;
import '../../features/auth/domain/repository/auth_repository.dart' as _i8;
import '../../features/auth/domain/use_case/get_token_use_case.dart' as _i10;
import '../../features/auth/domain/use_case/login_use_case.dart' as _i14;
import '../../features/auth/domain/use_case/logout_use_case.dart' as _i15;
import '../../features/auth/domain/use_case/register_use_case.dart' as _i16;
import '../../features/auth/presentation/bloc/auth_cubit/auth_cubit.dart'
    as _i18;
import '../../features/home/data/repository/jobs_repository_impl.dart' as _i12;
import '../../features/home/data/services/remote/jobs_service.dart' as _i4;
import '../../features/home/domain/repository/jobs_repository.dart' as _i11;
import '../../features/home/domain/use_case/apply_use_case.dart' as _i17;
import '../../features/home/domain/use_case/jobs_use_case.dart' as _i13;
import '../../features/home/presentation/bloc/apply_cubit/apply_cubit.dart'
    as _i20;
import '../../features/home/presentation/bloc/home_cubit/home_cubit.dart'
    as _i19;
import '../modules_init/modules_init.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final modulesInit = _$ModulesInit();
  gh.factory<_i3.Dio>(() => modulesInit.dio);
  gh.singleton<_i4.JobsService>(_i4.JobsService(get<_i3.Dio>()));
  await gh.factoryAsync<_i5.SharedPreferences>(() => modulesInit.cacheInit,
      preResolve: true);
  gh.singleton<_i6.AuthApiService>(_i6.AuthApiService(get<_i3.Dio>()));
  gh.singleton<_i7.AuthLocalService>(
      _i7.AuthLocalServiceImpl(get<_i5.SharedPreferences>()));
  gh.factory<_i8.AuthRepository>(() =>
      _i9.AuthRepoImpl(get<_i6.AuthApiService>(), get<_i7.AuthLocalService>()));
  gh.factory<_i10.GetTokenUseCase>(
      () => _i10.GetTokenUseCase(get<_i8.AuthRepository>()));
  gh.factory<_i11.JobsRepository>(() => _i12.JobsRepositoryImpl(
      get<_i4.JobsService>(), get<_i7.AuthLocalService>()));
  gh.factory<_i13.JobsUseCase>(
      () => _i13.JobsUseCase(get<_i11.JobsRepository>()));
  gh.factory<_i14.LoginUseCase>(
      () => _i14.LoginUseCase(get<_i8.AuthRepository>()));
  gh.factory<_i15.LogoutUseCase>(
      () => _i15.LogoutUseCase(get<_i8.AuthRepository>()));
  gh.factory<_i16.RegisterUseCase>(
      () => _i16.RegisterUseCase(get<_i8.AuthRepository>()));
  gh.factory<_i17.ApplyUseCase>(
      () => _i17.ApplyUseCase(get<_i11.JobsRepository>()));
  gh.factory<_i18.AuthCubit>(() => _i18.AuthCubit(
      get<_i14.LoginUseCase>(),
      get<_i15.LogoutUseCase>(),
      get<_i16.RegisterUseCase>(),
      get<_i10.GetTokenUseCase>()));
  gh.factory<_i19.HomeCubit>(() => _i19.HomeCubit(get<_i13.JobsUseCase>()));
  gh.factory<_i20.ApplyCubit>(() => _i20.ApplyCubit(get<_i17.ApplyUseCase>()));
  return get;
}

class _$ModulesInit extends _i21.ModulesInit {}
