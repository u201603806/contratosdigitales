class Appointment {
  int status;
  String id;
  ServiceAppointment service;
  String startDate;
  String endDate;
  String createdAt;
  String updatedAt;

  Appointment(
      {this.status,
      this.id,
      this.service,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  Appointment.fromJson(Map<String, dynamic> json) {
    status = json['estado'];
    id = json['_id'];
    service = json['_servicio'] != null
        ? new ServiceAppointment.fromJson(json['_servicio'])
        : null;
    startDate = json['fechaInicio'];
    endDate = json['fechaFin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this.status;
    data['_id'] = this.id;
    if (this.service != null) {
      data['_servicio'] = this.service.toJson();
    }
    data['fechaInicio'] = this.startDate;
    data['fechaFin'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
class ServiceAppointment {
  BusinessAppointment businessAppointment;
  String name;
  int cost;
  int time;

  ServiceAppointment({this.businessAppointment, this.name, this.cost, this.time});

  ServiceAppointment.fromJson(Map<String, dynamic> json) {
    businessAppointment = json['_empresa'] != null
        ? new BusinessAppointment.fromJson(json['_empresa'])
        : null;
    name = json['nombreServicio'];
    cost = json['costo'];
    time = json['tiempo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessAppointment != null) {
      data['_empresa'] = this.businessAppointment.toJson();
    }
    data['nombreServicio'] = this.name;
    data['costo'] = this.cost;
    data['tiempo'] = this.time;
    return data;
  }
}

class BusinessAppointment {
  String name;
  String image;

  BusinessAppointment({this.name, this.image});

  BusinessAppointment.fromJson(Map<String, dynamic> json) {
    name = json['nombreEmpresa'];
    image = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombreEmpresa'] = this.name;
    data['imagen'] = this.image;
    return data;
  }
}