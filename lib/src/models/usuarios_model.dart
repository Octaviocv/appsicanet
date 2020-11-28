import 'package:flutter/cupertino.dart';

class UsuarioModel {
  int id;
  String nombre;
  String apellidos;

  UsuarioModel({ @required this.id, @required this.nombre,@required this.apellidos});

 Map<String,dynamic> toMap()=>{
   'id':id,
   'nombre':nombre,
   'apellidos':apellidos

 };

 factory UsuarioModel.fromJson(Map<String,dynamic> json)=>UsuarioModel(id: json['id'], nombre: json['nombre'], apellidos: json['apellidos']);

 String get getnombre {return nombre;}

String get getnnn => nombre.toUpperCase();
 

} 
