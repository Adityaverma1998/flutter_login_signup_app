import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  static const _isLoggedInKey = 'is_logged_in';
  static const _userMobileKey = 'user_mobile';

  final FlutterSecureStorage _storage;

  SessionService(this._storage);

  Future<void> saveUser(String mobile) async {
    await _storage.write(key: _isLoggedInKey, value: 'true');

    await _storage.write(key: _userMobileKey, value: mobile);
  }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedInKey);

    return value == 'true';
  }

  Future<String?> getUserMobile() async {
    return _storage.read(key: _userMobileKey);
  }

  Future<void> logout() async {
    await _storage.delete(key: _isLoggedInKey);

    await _storage.delete(key: _userMobileKey);
  }
}
