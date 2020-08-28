class BusinessService {
  String id;
  String idBusiness;
  String name;
  String description;
  int cost;
  int time;
  int stock;

  BusinessService(
      {this.id,
      this.idBusiness,
      this.name,
      this.description,
      this.cost,
      this.time,
      this.stock});

  BusinessService.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    idBusiness = json['_empresa'];
    name = json['nombreServicio'];
    description = json['descripcion'];
    cost = json['costo'];
    time = json['tiempo'];
    stock = json['cupos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['_empresa'] = this.idBusiness;
    data['nombreServicio'] = this.name;
    data['descripcion'] = this.description;
    data['costo'] = this.cost;
    data['tiempo'] = this.time;
    data['cupos'] = this.stock;
    return data;
  }
}