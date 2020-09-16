import 'package:digitalcontractsapp/data_models/enums/user_type.dart';

class User {
  String idUser;
  String codUser;
  String name;
  String googleID;
  String documentNumber;
  String phone;
  String email;
  String image;
  UserType userType;

  User({
    this.idUser,
    this.codUser,
    this.name,
    this.googleID,
    this.documentNumber,
    this.phone,
    this.email,
    this.image,
  });

  User.fromMap(Map<String, dynamic> data) {
    idUser = data['idUser'] ?? '';
    codUser = data['codUser'] ?? '';
    name = data['nombre'] ?? '';
    googleID = data['_id'] ?? '';
    documentNumber = data['ci'] ?? '';
    phone = data['telefono'] ?? '';
    email = data['usuario'] ?? '';
    image = data['imagen'] ?? '';
    userType = UserType.User;
  }
}
