import 'package:mi_bienestar_uc/models/specialisation.dart';

class Diagnosis {
  final Issue issue;
  final List<Specialisation> specialisations;

  Diagnosis({required this.issue, required this.specialisations});

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      issue: Issue.fromJson(json['Issue']),
      specialisations: List<Specialisation>.from(
          json['Specialisation'].map((data) => Specialisation.fromJson(data))),
    );
  }
}

class Issue {
  final int id;
  final String name;
  final double accuracy; // Cambiar de int a double
  final String icd;
  final String icdName;
  final String profName;
  final int ranking;

  Issue({
    required this.id,
    required this.name,
    required this.accuracy,
    required this.icd,
    required this.icdName,
    required this.profName,
    required this.ranking,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['ID'],
      name: json['Name'],
      accuracy: json['Accuracy']?.toDouble() ?? 0.0, // Convertir a double
      icd: json['Icd'],
      icdName: json['IcdName'],
      profName: json['ProfName'],
      ranking: json['Ranking'],
    );
  }
}
