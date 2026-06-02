import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_login_signup_app/data/database/user_dao.dart';
import 'package:flutter_login_signup_app/data/database/user_table.dart';
import 'package:flutter_login_signup_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserDao userDao;

  AuthRepositoryImpl(this.userDao);

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  @override
  Future<Either<String, bool>> registerUser(UserEntity user) async {
    try {
      final existingEmail = await userDao.getUserByEmail(user.email);

      if (existingEmail != null) {
        return const Left('Email already registered');
      }

      final existingMobile = await userDao.getUserByMobile(user.mobile);

      if (existingMobile != null) {
        return const Left('Mobile number already registered');
      }

      final hashedUser = UserEntity(
        name: user.name,
        email: user.email,
        mobile: user.mobile,
        password: _hashPassword(user.password),
        imagePath: user.imagePath,
      );

      await userDao.insertUser(hashedUser);

      return const Right(true);
    } catch (e) {
      return Left('Registration failed: $e');
    }
  }

  @override
  Future<Either<String, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await userDao.getUserByEmail(email);

      if (user == null) {
        return const Left('User not found');
      }

      final hashedPassword = _hashPassword(password);

      if (user.password != hashedPassword) {
        return const Left('Invalid password');
      }

      return Right(user);
    } catch (e) {
      return Left('Login failed: $e');
    }
  }

  @override
  Future<Either<String, UserEntity>> getUserById(int id) async {
    try {
      final user = await userDao.getUserById(id);

      if (user == null) {
        return const Left('User not found');
      }

      return Right(user);
    } catch (e) {
      return Left('Failed to fetch user: $e');
    }
  }

  @override
  Future<Either<String, bool>> isEmailExists(String email) async {
    try {
      final user = await userDao.getUserByEmail(email);

      return Right(user != null);
    } catch (e) {
      return Left('Failed to check email: $e');
    }
  }

  @override
  Future<Either<String, bool>> isMobileExists(String mobile) async {
    try {
      final user = await userDao.getUserByMobile(mobile);

      return Right(user != null);
    } catch (e) {
      return Left('Failed to check mobile: $e');
    }
  }

  @override
  Future<Either<String, UserEntity>> getUserByMobile(String mobile) async {
    try {
      final user = await userDao.getUserByMobile(mobile);

      if (user == null) {
        return const Left('User not found');
      }

      return Right(user);
    } catch (e) {
      return Left('Failed to fetch user: $e');
    }
  }
}
