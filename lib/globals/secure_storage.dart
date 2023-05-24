import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final secureStorage = const FlutterSecureStorage();

  Future<void> write(String key, value) async {
    secureStorage.write(key: key, value: value);
  }

  Future<dynamic> read(String key) async {
    return secureStorage.read(key: key);
  }

  void delete(String key) async {
    secureStorage.delete(key: key);
  }

  void deleteAll() async {
    secureStorage.deleteAll();
  }
}
