class UserLogin {
  int idUsuario;
  String codUsuario;
  String nombre;
  String apellido;
  String clave;
  String perfil;

  UserLogin(
      {this.idUsuario,
      this.codUsuario,
      this.nombre,
      this.apellido,
      this.clave,
      this.perfil});

  UserLogin.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    codUsuario = json['codUsuario'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    clave = json['clave'];
    perfil = json['perfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuario'] = this.idUsuario;
    data['codUsuario'] = this.codUsuario;
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['clave'] = this.clave;
    data['perfil'] = this.perfil;
    return data;
  }
}