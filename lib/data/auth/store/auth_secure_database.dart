import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenpin/data/auth/store/user_token_entity.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class AuthSecureDatabase {
  AuthSecureDatabase();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _key = 'greenpinUserToken';
  static const _iosOptions =
      IOSOptions(accessibility: IOSAccessibility.unlocked_this_device);

  Future<void> saveToken(UserTokenEntity entity) async {
    final json = jsonEncode(entity.toJson());
    await _storage.write(
      key: _key,
      value: json,
      iOptions: _iosOptions,
    );
  }

  Future<UserTokenEntity?> loadToken() async {
    final json = await _storage.read(key: _key, iOptions: _iosOptions);

    if (json == null) return null;

    return UserTokenEntity.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> clear() => _storage.delete(key: _key, iOptions: _iosOptions);
}
