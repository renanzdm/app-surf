import 'package:get_it/get_it.dart';
import 'package:surf_app/infrastructure/rest_client/custom_dio.dart';
import 'package:surf_app/infrastructure/rest_client/i_rest_client.dart';
import 'package:surf_app/modules/auth/login/data/datasource/user_login_datasource.dart';
import 'package:surf_app/modules/auth/login/domain/repositories/i_login_repository.dart';
import 'package:surf_app/modules/auth/login/domain/usecases/login_usecase.dart';
import 'package:surf_app/modules/auth/login/infra/datasources/i_user_login_datasource.dart';
import 'package:surf_app/modules/auth/login/infra/repository/user_login_repository.dart';
import 'package:surf_app/modules/auth/login/presenter/cubit/login_cubit.dart';
import 'package:surf_app/modules/auth/login/presenter/usecases/i_login_usecase.dart';
import 'package:surf_app/modules/auth/register/data/datasource/user_register_datasource.dart';
import 'package:surf_app/modules/auth/register/domain/repositories/i_register_repository.dart';
import 'package:surf_app/modules/auth/register/domain/usecases/register_usecase.dart';
import 'package:surf_app/modules/auth/register/infra/datasource/i_user_register_datasource.dart';
import 'package:surf_app/modules/auth/register/infra/repository/user_register_repository.dart';
import 'package:surf_app/modules/auth/register/presenter/cubit/register_cubit.dart';
import 'package:surf_app/modules/auth/register/presenter/usecase/i_register_usecase.dart';
import 'package:surf_app/modules/home/data/datasource/get_places_datasource.dart';
import 'package:surf_app/modules/home/data/datasource/get_user_datasource.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_places_repository.dart';
import 'package:surf_app/modules/home/domain/repositories/i_get_user_info_repository.dart';
import 'package:surf_app/modules/home/domain/usecases/home_usecase.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_places_datasource.dart';
import 'package:surf_app/modules/home/infra/datasources/i_get_user_infos_datasource.dart';
import 'package:surf_app/modules/home/infra/repository/get_places_repository.dart';
import 'package:surf_app/modules/home/infra/repository/get_user_infos_repository.dart';
import 'package:surf_app/modules/home/presenter/cubit/home_controller.dart';
import 'package:surf_app/modules/home/presenter/usecases/i_home_usercase.dart';

final getIt = GetIt.instance;

void loadDependecies() {
  getIt.registerLazySingleton<IRestClient>(() => CustomDio());
  getIt.registerFactory<IUserLoginDataSource>(
      () => UserLoginDatasource(getIt<IRestClient>()));
  getIt.registerFactory<IUserRegisterDatasource>(
      () => UserRegisterDatasource(getIt<IRestClient>()));
  getIt.registerFactory<IGetUserInfosDataSource>(
      () => GetUserDatasource(getIt<IRestClient>()));
  getIt.registerFactory<IGetUserInfosRepository>(
      () => GetUserInfosRepository(getIt<IGetUserInfosDataSource>()));
  getIt.registerFactory<IHomeUseCase>(() => HomeUseCase(
      getIt<IGetUserInfosRepository>(), getIt.get<IGetPlacesRepository>()));
  getIt.registerFactory<ILoginRepository>(
      () => UserLoginRepository(getIt<IUserLoginDataSource>()));
  getIt.registerFactory<ILoginUseCase>(
      () => LoginUseCase(getIt<ILoginRepository>()));
  getIt.registerFactory<IRegisterUserRepository>(
      () => UserRegisterRepository(getIt<IUserRegisterDatasource>()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<ILoginUseCase>()));
  getIt.registerFactory<HomeController>(() => HomeController(getIt<IHomeUseCase>()));
  getIt.registerFactory<IRegisterUseCase>(
      () => Register(getIt<IRegisterUserRepository>()));
  getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(getIt<IRegisterUseCase>()));
  getIt.registerLazySingleton<IGetPlacesDataSource>(
      () => GetPlacesDataSource(getIt.get<IRestClient>()));
  getIt.registerLazySingleton<IGetPlacesRepository>(
      () => GetPlacesRepository(getIt.get<IGetPlacesDataSource>()));
}
