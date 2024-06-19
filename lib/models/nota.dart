class Nota {
  int? id;
  String? student;
  String? materia;
  double? nota;
  int? gestion;

  Nota({
    this.id,
    this.student,
    this.materia,
    this.nota,
    this.gestion,
  });

  factory Nota.fromJson(Map<String, dynamic> json) {
    return Nota(
      id: json['id'],
      student: json['student'],
      materia: json['materia'],
      nota: json['nota'],
      gestion: json['gestion'],
    );
  }

  factory Nota.fromJsonNotas(Map<String, dynamic> json) {
    return Nota(
      id: json['id'],
      student: json['student'],
      materia: json['materia'],
      nota: json['nota'],
      gestion: json['gestion'],
    );
  }
}
