class ContractColaboratorSample {
  String puesto;
  String inicio;
  String fin;
  String nombre;
  String dni;

  ContractColaboratorSample(
      {this.puesto, this.inicio, this.fin, this.nombre, this.dni});

  ContractColaboratorSample.fromJson(Map<String, dynamic> json) {
    puesto = json['puesto'];
    inicio = json['inicio'];
    fin = json['fin'];
    nombre = json['nombre'];
    dni = json['dni'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['puesto'] = this.puesto;
    data['inicio'] = this.inicio;
    data['fin'] = this.fin;
    data['nombre'] = this.nombre;
    data['dni'] = this.dni;
    return data;
  }
}