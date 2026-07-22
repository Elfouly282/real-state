import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_keys.dart';

export 'secure_keys.dart';
export 'auth_storage.dart';

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
