class Alumno {
  int? id;
  String? rude;
  String? name;

  Alumno({
    this.id,
    this.name,
    this.rude,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      id: json['id'],
      name: json['name'],
      rude: json['rude']?.toString() ?? '',
    );
  }

  factory Alumno.fromJsonAlumnos(Map<String, dynamic> json) {
    return Alumno(
      id: json['id'],
      name: json['name'],
      rude: json['rude']?.toString() ?? '',
    );
  }
}
