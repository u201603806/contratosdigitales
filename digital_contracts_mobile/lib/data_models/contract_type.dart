class ContractType {
  int idTipo;
  String nombre;
  String detalle;

  ContractType({this.idTipo, this.nombre, this.detalle});

  ContractType.fromJson(Map<String, dynamic> json) {
    idTipo = json['idTipo'];
    nombre = json['nombre'];
    detalle = json['detalle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTipo'] = this.idTipo;
    data['nombre'] = this.nombre;
    data['detalle'] = this.detalle;
    return data;
  }
}