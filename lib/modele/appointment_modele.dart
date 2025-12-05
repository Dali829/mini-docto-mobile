class Crenau {
  final String id;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;

  Crenau({
    required this.id,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
  });

  factory Crenau.fromJson(Map<String, dynamic> json) {
    return Crenau(
      id: json['_id'],
      description: json['description'],
      dateDebut: DateTime.parse(json['dateDebut']),
      dateFin: DateTime.parse(json['dateFin']),
    );
  }
}

class Pro {
  final String id;
  final String nom;
  final String prenom;
  final String email;

  Pro({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  factory Pro.fromJson(Map<String, dynamic> json) {
    return Pro(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
    );
  }

  String get fullName => "$prenom $nom";
}

class Appointment {
  final String id;
  final Crenau creneauId;
  final String patientId;
  final Pro proId;
  final DateTime dateReservation;
   String? statut;

  Appointment({
    required this.id,
    required this.creneauId,
    required this.patientId,
    required this.proId,
    required this.dateReservation,
    this.statut
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      creneauId: Crenau.fromJson(json['creneauId']),
      patientId: json['patientId'],
      proId: Pro.fromJson(json['proId']),
      dateReservation: DateTime.parse(json['dateReservation']),
      statut: json['statut'],
    );
  }
}
