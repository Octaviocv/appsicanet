class UserModel{
  String id;
  String usuario;
  String email;
  String nummovil;

 

  UserModel({this.id,this.usuario,this.email,this.nummovil});

  factory UserModel.fromJsonMap(Map<String,dynamic> json) => UserModel(
    id : json['id'],
    usuario:  json['usuario'],
    email : json['email'],
    nummovil:json['nummovil'],
  );

  UserModel.fromJsonMapC(Map<String,dynamic> json){
      id = json['id'];
      email = json['email'];
      usuario = json['usuario'];
      nummovil=json['nummovil'];
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'usuario':usuario,
    'email':email,
    'nummovil':nummovil,

  };

}