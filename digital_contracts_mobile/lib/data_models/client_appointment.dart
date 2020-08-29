class ClientAppointment {
  int status;
  String id;
  BusinessService service;
  UserAppointment user;
  String startDate;
  String endDate;
  String createdAt;
  String updatedAt;

  ClientAppointment(
      {this.status,
      this.id,
      this.service,
      this.user,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  ClientAppointment.fromJson(Map<String, dynamic> json) {
    status = json['estado'];
    id = json['_id'];
    service = json['_servicio'] != null
        ? new BusinessService.fromJson(json['_servicio'])
        : null;
    user = json['_usuario'] != null
        ? new UserAppointment.fromJson(json['_usuario'])
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
    if (this.user != null) {
      data['_usuario'] = this.user.toJson();
    }
    data['fechaInicio'] = this.startDate;
    data['fechaFin'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class BusinessService {
  String name;
  int cost;

  BusinessService({this.name, this.cost});

  BusinessService.fromJson(Map<String, dynamic> json) {
    name = json['nombreServicio'];
    cost = json['costo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombreServicio'] = this.name;
    data['costo'] = this.cost;
    return data;
  }
}

class UserAppointment {
  String id;
  String email;
  String name;

  UserAppointment({this.id, this.email, this.name});

  UserAppointment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['usuario'];
    name = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['usuario'] = this.email;
    data['nombre'] = this.name;
    return data;
  }
}