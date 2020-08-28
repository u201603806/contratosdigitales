import 'package:digitalcontractsapp/data_models/business.dart';

class Rubro {
  String id;
  String name;
  String description;
  String image;
  List<Business> businessList;

  Rubro({this.id, this.name, this.description, this.image});

  Rubro.fromJson(Map json) {
    this.id = json['_id'];
    this.name = json['nombreRubro'];
    this.description = json['descripcion'];
    this.image = json['imagen'];
    if (json['_empresa'] != null) {
      this.businessList = new List<Business>();
      if (json['_empresa'].isEmpty || json['_empresa'].first is String) return;
      json['_empresa'].forEach((v) {
        this.businessList.add(new Business.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nombreRubro'] = this.name;
    data['descripcion'] = this.description;
    data['imagen'] = this.image;
    if (this.businessList != null) {
      data['_empresa'] = this.businessList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
