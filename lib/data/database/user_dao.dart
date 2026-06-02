import 'package:floor/floor.dart';
import 'package:flutter_login_signup_app/data/database/user_table.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(UserEntity user);

  @update
  Future<void> updateUser(UserEntity user);

  @delete
  Future<void> deleteUser(UserEntity user);

  @Query('SELECT * FROM users WHERE email = :email LIMIT 1')
  Future<UserEntity?> getUserByEmail(String email);

  @Query('SELECT * FROM users WHERE mobile = :mobile LIMIT 1')
  Future<UserEntity?> getUserByMobile(String mobile);

  @Query('SELECT * FROM users WHERE id = :id LIMIT 1')
  Future<UserEntity?> getUserById(int id);

  @Query('SELECT * FROM users')
  Future<List<UserEntity>> getAllUsers();

  @Query('DELETE FROM users')
  Future<void> deleteAllUsers();
}
