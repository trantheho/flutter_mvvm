import 'package:flutter_mvvm/domain/models/account_model.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login({required String email, required String password});

  Future<void> logout();

  Future<bool> createAnAccount(AccountModel account);
}
