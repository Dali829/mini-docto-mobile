import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/signup_repository.dart';
import '../datasources/signup_remote_datasource.dart';
import '../models/user_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remote;

  SignupRepositoryImpl(this.remote);

  @override
  Future<void> signup(UserEntity user) {
    final model = UserModel(
      nom: user.nom,
      prenom: user.prenom,
      email: user.email,
      password: user.password,
    );

    return remote.signup(model);
  }
}