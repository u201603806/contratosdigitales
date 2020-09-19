class DocumentByShipment {
  int idDocumento;
  String dni;
  String cargo;
  String jefe;
  String area;
  double sueldo;
  int idEstado;
  int idEnvio;

  DocumentByShipment(
      {this.idDocumento,
      this.dni,
      this.cargo,
      this.jefe,
      this.area,
      this.sueldo,
      this.idEstado,
      this.idEnvio});

  DocumentByShipment.fromJson(Map<String, dynamic> json) {
    idDocumento = json['idDocumento'];
    dni = json['dni'];
    cargo = json['cargo'];
    jefe = json['jefe'];
    area = json['area'];
    sueldo = json['sueldo'];
    idEstado = json['idEstado'];
    idEnvio = json['idEnvio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDocumento'] = this.idDocumento;
    data['dni'] = this.dni;
    data['cargo'] = this.cargo;
    data['jefe'] = this.jefe;
    data['area'] = this.area;
    data['sueldo'] = this.sueldo;
    data['idEstado'] = this.idEstado;
    data['idEnvio'] = this.idEnvio;
    return data;
  }
}