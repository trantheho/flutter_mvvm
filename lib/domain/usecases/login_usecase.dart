import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/data/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_mvvm/data/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final loginUserCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return LoginUseCase(authRepository);
});

class LoginUseCase{
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);


  Future<UserModel?> run({required String email, required String password}) async {
    final user = await authRepository.login(email: email, password: password);
    debugPrint('user data: $user');
    return user;
  }
}