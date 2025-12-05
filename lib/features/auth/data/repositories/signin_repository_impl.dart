import '../../domain/entities/signin_entity.dart';
import '../../domain/repositories/signin_repository.dart';
import '../datasources/signin_remote_datasource.dart';
import '../models/signin_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;

  LoginRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> login(LoginEntity user) {
    final model = LoginModel(
      email: user.email,
      password: user.password,
    );

    return remote.login(model);
  }
}