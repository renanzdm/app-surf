// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/auth/login/data/datasource/user_login_datasource.dart'
    as _i6;
import '../../modules/auth/login/domain/repositories/i_login_repository.dart'
    as _i9;
import '../../modules/auth/login/domain/usecases/login_usecase.dart' as _i14;
import '../../modules/auth/login/infra/datasources/i_user_login_datasource.dart'
    as _i5;
import '../../modules/auth/login/infra/repository/user_login_repository.dart'
    as _i10;
import '../../modules/auth/login/presenter/cubit/login_cubit.dart' as _i17;
import '../../modules/auth/login/presenter/usecases/i_login_usecase.dart'
    as _i13;
import '../../modules/auth/register/data/datasource/user_register_datasource.dart'
    as _i8;
import '../../modules/auth/register/domain/repositories/i_register_repository.dart'
    as _i11;
import '../../modules/auth/register/domain/usecases/register_usecase.dart'
    as _i16;
import '../../modules/auth/register/infra/datasource/i_user_register_datasource.dart'
    as _i7;
import '../../modules/auth/register/infra/repository/user_register_repository.dart'
    as _i12;
import '../../modules/auth/register/presenter/cubit/register_cubit.dart'
    as _i18;
import '../../modules/auth/register/presenter/usecase/i_register_usecase.dart'
    as _i15;
import '../rest_client/custom_dio.dart' as _i4;
import '../rest_client/i_rest_client.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IRestClient>(() => _i4.CustomDio());
  gh.factory<_i5.IUserLoginDataSource>(
      () => _i6.UserLoginDatasource(get<_i3.IRestClient>()));
  gh.factory<_i7.IUserRegisterDatasource>(
      () => _i8.UserRegisterDatasource(get<_i3.IRestClient>()));
  gh.factory<_i9.ILoginRepository>(
      () => _i10.UserLoginRepository(get<_i5.IUserLoginDataSource>()));
  gh.factory<_i11.IRegisterUserRepository>(
      () => _i12.UserRegisterRepository(get<_i7.IUserRegisterDatasource>()));
  gh.factory<_i13.ILoginUseCase>(
      () => _i14.LoginUseCase(get<_i9.ILoginRepository>()));
  gh.factory<_i15.IRegisterUseCase>(
      () => _i16.Register(get<_i11.IRegisterUserRepository>()));
  gh.factory<_i17.LoginCubit>(() => _i17.LoginCubit(get<_i13.ILoginUseCase>()));
  gh.factory<_i18.RegisterCubit>(
      () => _i18.RegisterCubit(get<_i15.IRegisterUseCase>()));
  return get;
}
