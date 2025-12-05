import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.nom,
    required super.prenom,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "password": password,
    };
  }
}
