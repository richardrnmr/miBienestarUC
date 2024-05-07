class Specialisation {
  final int id;
  final String name;
  final int specialistId;

  Specialisation({
    required this.id,
    required this.name,
    required this.specialistId,
  });

  factory Specialisation.fromJson(Map<String, dynamic> json) {
    return Specialisation(
      id: json['ID'],
      name: json['Name'],
      specialistId: json['SpecialistID'],
    );
  }
}