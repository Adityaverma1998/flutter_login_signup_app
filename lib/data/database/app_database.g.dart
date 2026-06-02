// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`mobile` TEXT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `imagePath` TEXT NOT NULL, PRIMARY KEY (`mobile`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'mobile': item.mobile,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'imagePath': item.imagePath
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['mobile'],
            (UserEntity item) => <String, Object?>{
                  'mobile': item.mobile,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'imagePath': item.imagePath
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['mobile'],
            (UserEntity item) => <String, Object?>{
                  'mobile': item.mobile,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'imagePath': item.imagePath
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    return _queryAdapter.query('SELECT * FROM users WHERE email = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => UserEntity(
            mobile: row['mobile'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            imagePath: row['imagePath'] as String),
        arguments: [email]);
  }

  @override
  Future<UserEntity?> getUserByMobile(String mobile) async {
    return _queryAdapter.query('SELECT * FROM users WHERE mobile = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => UserEntity(
            mobile: row['mobile'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            imagePath: row['imagePath'] as String),
        arguments: [mobile]);
  }

  @override
  Future<UserEntity?> getUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => UserEntity(
            mobile: row['mobile'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            imagePath: row['imagePath'] as String),
        arguments: [id]);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => UserEntity(
            mobile: row['mobile'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            imagePath: row['imagePath'] as String));
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM users');
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _userEntityUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    await _userEntityDeletionAdapter.delete(user);
  }
}
