class Country {
  String id;
  String name;
  String code;
  String coin;

  Country({this.id, this.name, this.code, this.coin});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['nombre'];
    code = json['codigo'];
    coin = json['moneda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nombre'] = this.name;
    data['codigo'] = this.code;
    data['moneda'] = this.coin;
    return data;
  }
}