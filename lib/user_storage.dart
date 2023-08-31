import 'package:storage/storage.dart';

/// Storage keys for the [UserStorage].
abstract class UserStorageKeys {
  static const accessToken = '__access_token__';
  static const userName = '__user_name__';
  static const userPassword = '__user_password__';
}

class UserStorage {
  const UserStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  Future<void> setAccessToken({required int count}) => _storage.write(
        key: UserStorageKeys.accessToken,
        value: count.toString(),
      );


  Future<String> fetchUserName() async {
    final name = await _storage.read(
      key: UserStorageKeys.userName,
    );
    return name.toString();
  }

  Future<void> setUserName({required String name}) => _storage.write(
        key: UserStorageKeys.userName,
        value: name,
      );

  Future<void> deleteUserName() => _storage.delete(
        key: UserStorageKeys.userName,
      );
}
