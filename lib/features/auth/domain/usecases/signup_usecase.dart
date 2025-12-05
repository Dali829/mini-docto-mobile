import '../entities/user_entity.dart';
import '../repositories/signup_repository.dart';

class SignupUseCase {
  final SignupRepository repo;

  SignupUseCase(this.repo);

  Future<void> call(UserEntity user) async {
    return await repo.signup(user);
  }
}