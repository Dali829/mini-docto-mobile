import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../features/auth/presentation/connexion_view.dart';
import '../modele/appointment_modele.dart';

class MesRendezVousViewModel extends ChangeNotifier {
  List<Appointment> appointments = [];
  bool loading = true;
  String? error;

  MesRendezVousViewModel() {
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final url = Uri.parse("http://localhost:8800/api/appointment/my");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        appointments =
            jsonList.map((item) => Appointment.fromJson(item)).toList();
      } else {
        error = "Erreur serveur : ${response.statusCode}";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        throw Exception("Utilisateur non connecté");
      }

      final url =
      Uri.parse("http://localhost:8800/api/appointment/cancel/$appointmentId");

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Mise à jour locale : changer le statut dans la liste
        final index = appointments.indexWhere((a) => a.id == appointmentId);
        if (index != -1) {
          appointments[index].statut = "annuler par client";
          notifyListeners();
        }
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? "Erreur lors de l'annulation");
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

}
