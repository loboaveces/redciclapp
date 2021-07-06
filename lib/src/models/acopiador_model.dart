// To parse this JSON data, do
//
//     final Acopiador = AcopiadorFromJson(jsonString);

import 'dart:convert';

Acopiador acopiadorFromJson(String str) => Acopiador.fromJson(json.decode(str));

String acopiadorToJson(Acopiador data) => json.encode(data.toJson());

class Acopiador {
  Acopiador({
    this.id,
    this.celular,
    this.ciudad,
    this.detalles,
    this.nombre,
    this.querecibe,
    this.direccion,
    this.zona,
    this.fotourl,
    this.fecha,
    this.latitud,
    this.longitud,
    this.horarios,
    this.correo,
    this.aprobacion,
    this.tienedenuncia,
    this.detalledenuncia,
  });

  String id;
  String celular;
  String ciudad;
  String detalles;
  String nombre;
  String direccion;
  String zona;
  String fotourl;
  String fecha;
  String querecibe;
  String latitud;
  String longitud;
  String horarios;
  String correo;
  String aprobacion;
  String tienedenuncia;
  String detalledenuncia;

  factory Acopiador.fromJson(Map<String, dynamic> json) => Acopiador(
        id: json["id"],
        celular: json["celular"],
        ciudad: json["ciudad"],
        detalles: json["detalles"],
        nombre: json["nombre"],
        querecibe: json["querecibe"],
        direccion: json["direccion"],
        zona: json["zona"],
        fotourl: json["fotourl"],
        fecha: json["fecha"],
        correo: json["correo"],
        horarios: json["horarios"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        aprobacion: json["aprobacion"],
        tienedenuncia: json["tienedenuncia"],
        detalledenuncia: json["detalledenuncia"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "celular": celular,
        "ciudad": ciudad,
        "detalles": detalles,
        "nombre": nombre,
        "querecibe": querecibe,
        "direccion": direccion,
        "zona": zona,
        "fotourl": fotourl,
        "fecha": fecha,
        "latitud": latitud,
        "longitud": longitud,
        "correo": correo,
        "horarios": horarios,
        "aprobacion": aprobacion,
        "tienedenuncia": tienedenuncia,
        "detalledenuncia": detalledenuncia,
      };
}
