import '../entities/signin_entity.dart';

abstract class LoginRepository {
  Future<Map<String, dynamic>> login(LoginEntity user);
}