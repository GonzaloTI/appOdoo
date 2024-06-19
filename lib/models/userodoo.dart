class Userodoo {
  int? id;
  String? ci;
  String? name;
  String? keynotificaciones;

  Userodoo({this.id, this.ci, this.name, this.keynotificaciones});

  factory Userodoo.fromJson(Map<String, dynamic> json) {
    return Userodoo(
      id: json['id'],
      ci: json['ci'],
      name: json['name'],
      keynotificaciones: json['keynotificaciones'],
    );
  }

  factory Userodoo.fromJsonUsers(Map<String, dynamic> json) {
    return Userodoo(
      id: json['id'],
      name: json['name'],
      ci: json['ci'],
      keynotificaciones: json['keynotificaciones'],
      // token: json['token'],
    );
  }
}
