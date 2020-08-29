import 'package:digitalcontractsapp/data_models/business_service.dart';

import 'country.dart';

class Business {
  int score;
  bool requireConfirmation;
  bool requireAddedValue;
  bool blocked;
  String id;
  String name;
  String description;
  String address;
  double latitude;
  double longitude;
  String image;
  Country country;
  String scheduleGeneral;
  List<BusinessService> services;

  Business(
      {this.score,
      this.requireConfirmation,
      this.requireAddedValue,
      this.blocked,
      this.id,
      this.name,
      this.description,
      this.address,
      this.latitude,
      this.longitude,
      this.image,
      this.country,
      this.scheduleGeneral});

  Business.fromJson(Map<String, dynamic> json) {
    score = json['puntuacion'];
    requireConfirmation = json['requiereConfirmacion']?? false;
    requireAddedValue = json['requiereValorAgregado'] ?? false;
    blocked = json['bloqueado'] ?? false;
    id = json['_id'] ?? '';
    name = json['nombreEmpresa'] ?? '';
    description = json['descripcion']?? '';
    address = json['direccion']?? '';
    latitude = json['latitud']?? '';
    longitude = json['longitud']?? '';
    image = json['imagen'] ?? '';
    country = json['_pais'] != null ? new Country.fromJson(json['_pais']) : null;
    scheduleGeneral = json['horarioGeneral']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['puntuacion'] = this.score;
    data['requiereConfirmacion'] = this.requireConfirmation;
    data['requiereValorAgregado'] = this.requireAddedValue;
    data['bloqueado'] = this.blocked;
    data['_id'] = this.id;
    data['nombreEmpresa'] = this.name;
    data['descripcion'] = this.description;
    data['direccion'] = this.address;
    data['latitud'] = this.latitude;
    data['longitud'] = this.longitude;
    data['imagen'] = this.image;
    if (this.country != null) {
      data['_pais'] = this.country.toJson();
    }
    data['horarioGeneral'] = this.scheduleGeneral;
    if (this.services != null) {
      data['_servicios'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}