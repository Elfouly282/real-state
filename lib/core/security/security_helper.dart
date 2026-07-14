import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../save data/save_data.dart';

class SecureKeys {
  static const String token = 'token';
  static const String name = 'name';
  static const String userId = 'userid';
  static const String tempUserId = 'temp_user_id';
}

class SecurityHelper {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  Future<bool> containsKey({required String key}) async {
    return await storage.containsKey(key: key);
  }

  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }
}

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
