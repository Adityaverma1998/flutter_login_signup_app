import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class UserEntity extends Equatable {
  @PrimaryKey()
  final String mobile;

  final String name;
  final String email;
  final String password;
  final String imagePath;

  const UserEntity({
    required this.mobile,
    required this.name,
    required this.email,
    required this.password,
    required this.imagePath,
  });

  UserEntity copyWith({
    String? mobile,
    String? name,
    String? email,
    String? password,
    String? imagePath,
  }) {
    return UserEntity(
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [mobile, name, email, password, imagePath];

  @override
  String toString() {
    return '''
UserEntity(
  mobile: $mobile,
  name: $name,
  email: $email,
  imagePath: $imagePath
)
''';
  }
}
