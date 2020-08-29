// To parse this JSON data, do
//
//     final Ecoemprendimiento = EcoemprendimientoFromJson(jsonString);

import 'dart:convert';

Ecoemprendimiento ecoemprendimientoFromJson(String str) =>
    Ecoemprendimiento.fromJson(json.decode(str));

String ecoemprendimientoToJson(Ecoemprendimiento data) =>
    json.encode(data.toJson());

class Ecoemprendimiento {
  Ecoemprendimiento({
    this.id,
    this.celular,
    this.ciudad,
    this.detalles,
    this.capacidad,
    this.nombre,
    this.quenecesita,
    this.direccion,
    this.zona,
    this.fotourl,
    this.fecha,
    this.latitud,
    this.longitud,
    this.descripcion,
    this.correo,
    this.horarios,
  });

  String id;
  String celular;
  String ciudad;
  String detalles;
  String capacidad;
  String nombre;
  String direccion;
  String zona;
  String fotourl;
  String fecha;
  String quenecesita;
  String latitud;
  String longitud;
  String descripcion;
  String correo;
  String horarios;

  factory Ecoemprendimiento.fromJson(Map<String, dynamic> json) =>
      Ecoemprendimiento(
        id: json["id"],
        celular: json["celular"],
        ciudad: json["ciudad"],
        detalles: json["detalles"],
        capacidad: json["capacidad"],
        nombre: json["nombre"],
        quenecesita: json["quenecesita"],
        direccion: json["direccion"],
        zona: json["zona"],
        fotourl: json["fotourl"],
        fecha: json["fecha"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        descripcion: json["descripcion"],
        correo: json["correo"],
        horarios: json["horarios"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "celular": celular,
        "ciudad": ciudad,
        "detalles": detalles,
        "capacidad": capacidad,
        "nombre": nombre,
        "quenecesita": quenecesita,
        "direccion": direccion,
        "zona": zona,
        "fotourl": fotourl,
        "fecha": fecha,
        "latitud": latitud,
        "longitud": longitud,
        "descripcion": descripcion,
        "correo": correo,
        "horarios": horarios,
      };
}
