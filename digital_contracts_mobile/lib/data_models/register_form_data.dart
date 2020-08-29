import 'rubro.dart';
import 'country.dart';

class RegisterFormData {
  List<Country> countries;
  List<Rubro> rubros;

  RegisterFormData({this.countries, this.rubros});

  RegisterFormData.fromJson(Map<String, dynamic> json) {
    if (json['_paises'] != null) {
      countries = new List<Country>();
      json['_paises'].forEach((v) {
        countries.add(new Country.fromJson(v));
      });
    }
    if (json['_rubros'] != null) {
      rubros = new List<Rubro>();
      json['_rubros'].forEach((v) {
        rubros.add(new Rubro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['_paises'] = this.countries.map((v) => v.toJson()).toList();
    }
    if (this.rubros != null) {
      data['_rubros'] = this.rubros.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
