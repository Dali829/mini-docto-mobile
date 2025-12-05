import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signin_model.dart';

abstract class LoginRemoteDataSource {
  Future<Map<String, dynamic>> login(LoginModel user);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final String baseUrl;

  LoginRemoteDataSourceImpl(this.baseUrl);

  @override
  Future<Map<String, dynamic>> login(LoginModel user) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode >= 400) {
      throw Exception(res.body);
    }

    return jsonDecode(res.body);
  }
}