import 'package:dartz/dartz.dart';
import 'package:flutter_login_signup_app/data/database/user_table.dart';

abstract class AuthRepository {
  Future<Either<String, bool>> registerUser(UserEntity user);

  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<String, UserEntity>> getUserByMobile(String mobile);

  Future<Either<String, bool>> isEmailExists(String email);

  Future<Either<String, bool>> isMobileExists(String mobile);
}
