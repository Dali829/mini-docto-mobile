import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../modele/crenau_modele.dart';

class ParametrageViewModel extends ChangeNotifier {
  final storage = FlutterSecureStorage();

  List<Pro> pros = [];
  Pro? selectedPro;
  bool loading = true;
  String? error;

  ParametrageViewModel() {
    loadPros();
  }

  Future<void> loadPros() async {
    try {
      final response =
      await http.get(Uri.parse("http://localhost:8800/api/users/pros"));
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        pros = jsonList.map((json) => Pro.fromJson(json)).toList();
        loading = false;
      } else {
        error = "Erreur serveur: ${response.statusCode}";
        loading = false;
      }
    } catch (e) {
      error = e.toString();
      loading = false;
    }
    notifyListeners();
  }

  void selectPro(Pro? pro) {
    selectedPro = pro;
    notifyListeners();
  }

  Future<bool> createAppointment(String creneauId, BuildContext context) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception("Utilisateur non connecté");
      }

      final url = Uri.parse("http://localhost:8800/api/appointment");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"creneauId": creneauId}),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succès !")));
        return true;
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'] ?? "Erreur")));
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }
}
