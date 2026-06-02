import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class UserEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String email;
  final String mobile;
  final String password;
  final String imagePath;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.imagePath,
  });
}
