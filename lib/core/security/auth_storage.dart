import '../save_data/save_data.dart';
import 'secure_keys.dart';
import 'security_helper.dart';

class AuthStorage {
  AuthStorage(this.security);

  final SecurityHelper security;

  String? token;
  String? userId;

  Future<void> migrateFromCacheIfNeeded(CacheHelper cacheHelper) async {
    final cachedToken = cacheHelper.getDataString(key: SecureKeys.token);
    final cachedUserId = cacheHelper
        .getData(key: SecureKeys.userId)
        ?.toString();

    if (cachedToken != null && cachedToken.trim().isNotEmpty) {
      await setToken(cachedToken.trim());
      await cacheHelper.removeData(key: SecureKeys.token);
    }

    if (cachedUserId != null && cachedUserId.trim().isNotEmpty) {
      await setUserId(cachedUserId.trim());
      await cacheHelper.removeData(key: SecureKeys.userId);
    }
  }

  Future<void> loadFromSecure() async {
    token = await security.read(key: SecureKeys.token);
    userId = await security.read(key: SecureKeys.userId);
  }

  Future<void> setToken(String value) async {
    await security.write(key: SecureKeys.token, value: value);
    token = value;
  }

  Future<void> setUserId(String value) async {
    await security.write(key: SecureKeys.userId, value: value);
    userId = value;
  }

  Future<void> clearAuth() async {
    await security.deleteAll();
    token = null;
    userId = null;
  }
}
