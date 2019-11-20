
class UserRegistrar {

  String nombre;
    String get getNombre => nombre;

  String apellidoP;
    String get getApellidoP => apellidoP;

  String apellidoM;
   String get getApellidoM => apellidoM;

  String dni;
   String get getDNI => dni;

  String telefono;
   String get getTelefono => telefono;

  String email;
   String get getEmail => email;

  String usuario;
   String get getUsuario => usuario;

  String contrasena;
    String get getContrasena => contrasena;


   UserRegistrar({ this.nombre, this.apellidoP, this.apellidoM, this.dni, this.telefono, this.email, this.usuario, this.contrasena });

}