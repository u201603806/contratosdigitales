class Shipment {
  int idEnvio;
  String datos;
  String fechaRegistro;
  int cantidad;
  int idTipo;
  Null idUsuario;
  int idEstado;

  Shipment(
      {this.idEnvio,
      this.datos,
      this.fechaRegistro,
      this.cantidad,
      this.idTipo,
      this.idUsuario,
      this.idEstado});

  Shipment.fromJson(Map<String, dynamic> json) {
    idEnvio = json['idEnvio'];
    datos = json['datos'];
    fechaRegistro = json['fechaRegistro'];
    cantidad = json['cantidad'];
    idTipo = json['idTipo'];
    idUsuario = json['idUsuario'];
    idEstado = json['idEstado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEnvio'] = this.idEnvio;
    data['datos'] = this.datos;
    data['fechaRegistro'] = this.fechaRegistro;
    data['cantidad'] = this.cantidad;
    data['idTipo'] = this.idTipo;
    data['idUsuario'] = this.idUsuario;
    data['idEstado'] = this.idEstado;
    return data;
  }
}