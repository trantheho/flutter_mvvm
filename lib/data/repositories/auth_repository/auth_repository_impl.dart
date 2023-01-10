import 'package:flutter_mvvm/data/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_mvvm/domain/models/account_model.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasources/remote/auth_remote_datasource.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = ref.watch(authRemoteDataSourceProvider);

  return AuthRepositoryImpl(authRemoteDataSource);
});

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);


  @override
  Future<UserModel?> login({required String email, required String password}) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> createAnAccount(AccountModel account) async {
    final result = await Future.delayed(const Duration(seconds: 2)).then((value) => true);

    return result;
  }
}