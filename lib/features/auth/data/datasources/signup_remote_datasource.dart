import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class SignupRemoteDataSource {
  Future<void> signup(UserModel user);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final String baseUrl;

  SignupRemoteDataSourceImpl(this.baseUrl);

  @override
  Future<void> signup(UserModel user) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode >= 400) {
      throw Exception(res.body);
    }
  }
}
