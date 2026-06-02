import 'package:floor/floor.dart';
import 'package:flutter_login_signup_app/data/database/user_table.dart';

import 'user_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [UserEntity])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
