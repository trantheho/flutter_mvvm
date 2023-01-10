import 'package:flutter_mvvm/data/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_mvvm/data/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_mvvm/domain/models/account_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createAnAccountUseCaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return CreateAnAccountUseCase(authRepository);
});

class CreateAnAccountUseCase {
  final AuthRepository authRepository;

  CreateAnAccountUseCase(this.authRepository);

  Future<bool> run(AccountModel account) async {
    final result = await authRepository.createAnAccount(account);

    return result;
  }
}
