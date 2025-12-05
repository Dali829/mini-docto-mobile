import '../entities/user_entity.dart';

abstract class SignupRepository {
  Future<void> signup(UserEntity user);
}