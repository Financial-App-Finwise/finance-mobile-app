import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  late String key;

  CacheService({this.key = ''});

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void write(String? value) {
    _storage.write(key: key, value: value);
  }

  Future<String?> read() async {
    return _storage.read(key: key);
  }
}