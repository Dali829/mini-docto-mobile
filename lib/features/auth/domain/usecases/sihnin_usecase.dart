import '../entities/signin_entity.dart';
import '../repositories/signin_repository.dart';

class LoginUseCase {
  final LoginRepository repo;

  LoginUseCase(this.repo);

  Future<Map<String, dynamic>> call(LoginEntity user) async {
    return await repo.login(user);
  }
}