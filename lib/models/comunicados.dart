class Comunicados {
  int? id;
  String? name;
  String? descripcion;

  Comunicados({this.id, this.descripcion, this.name});

  factory Comunicados.fromJsonComunicados(Map<String, dynamic> json) {
    return Comunicados(
        id: json['id'], descripcion: json['descripcion'], name: json['name']);
  }
}
