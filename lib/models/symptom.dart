class Symptom {
  final int id;
  final String name;

  Symptom({required this.id, required this.name});

  factory Symptom.fromJson(Map<String, dynamic> json) =>
      Symptom(id: json['ID'], name: json['Name']);
}