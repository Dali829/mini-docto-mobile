import '../../domain/entities/signin_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}