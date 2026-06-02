import 'package:flutter_login_signup_app/core/services/session_service.dart';
import 'package:flutter_login_signup_app/data/database/app_database.dart';
import 'package:flutter_login_signup_app/data/repositories/auth_repository_impl.dart';
import 'package:flutter_login_signup_app/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app.db').build();

  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerLazySingleton(() => database.userDao);

  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  getIt.registerLazySingleton(() => SessionService(getIt()));

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
}
