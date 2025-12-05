class Crenau {
  final String id;
  final String proId;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;

  Crenau({
    required this.id,
    required this.proId,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
  });

  factory Crenau.fromJson(Map<String, dynamic> json) {
    return Crenau(
      id: json['_id'],
      proId: json['proId'],
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
  final List<Crenau> crenaux;

  Pro({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.crenaux,
  });

  factory Pro.fromJson(Map<String, dynamic> json) {
    var list = json['crenaux'] as List;
    List<Crenau> crenauxList = list.map((c) => Crenau.fromJson(c)).toList();

    return Pro(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      crenaux: crenauxList,
    );
  }

  String get fullName => "$prenom $nom";
}
