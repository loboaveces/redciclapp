// To parse this JSON data, do
//
//     final recicladora = recicladoraFromJson(jsonString);

import 'dart:convert';

Recicladora recicladoraFromJson(String str) =>
    Recicladora.fromJson(json.decode(str));

String recicladoraToJson(Recicladora data) => json.encode(data.toJson());

class Recicladora {
  Recicladora({
    this.id,
    this.celular,
    this.departamento,
    this.detalles,
    this.provincia,
    this.nombre,
    this.recolecta,
    this.ruta,
    this.zona,
    this.fotourl,
    this.fecha,
    this.dias,
    this.horarios,
    this.correo,
    this.tienedenuncia,
    this.detalledenuncia,
  });

  String id;
  String celular;
  String departamento;
  String detalles;
  String provincia;
  String nombre;
  String recolecta;
  String ruta;
  String zona;
  String fotourl;
  String fecha;
  String dias;
  String horarios;
  String correo;
  String tienedenuncia;
  String detalledenuncia;

  factory Recicladora.fromJson(Map<String, dynamic> json) => Recicladora(
        id: json["id"],
        celular: json["celular"],
        departamento: json["departamento"],
        detalles: json["detalles"],
        provincia: json["provincia"],
        nombre: json["nombre"],
        recolecta: json["recolecta"],
        ruta: json["ruta"],
        zona: json["zona"],
        fotourl: json["fotourl"],
        fecha: json["fecha"],
        dias: json["dias"],
        horarios: json["horarios"],
        correo: json["correo"],
        tienedenuncia: json["tienedenuncia"],
        detalledenuncia: json["detalledenuncia"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "celular": celular,
        "departamento": departamento,
        "detalles": detalles,
        "provincia": provincia,
        "nombre": nombre,
        "recolecta": recolecta,
        "ruta": ruta,
        "zona": zona,
        "fotourl": fotourl,
        "fecha": fecha,
        "dias": dias,
        "horarios": horarios,
        "correo": correo,
        "tienedenuncia": tienedenuncia,
        "detalledenuncia": detalledenuncia,
      };
}
