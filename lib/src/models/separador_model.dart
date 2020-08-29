// To parse this JSON data, do
//
//     final Separador = SeparadorFromJson(jsonString);

import 'dart:convert';

Separador separadorFromJson(String str) => Separador.fromJson(json.decode(str));

String separadorToJson(Separador data) => json.encode(data.toJson());

class Separador {
  Separador({
    this.id,
    this.celular,
    this.departamento,
    this.detalles,
    this.provincia,
    this.nombre,
    this.quesepara,
    this.zona,
    this.fecha,
  });

  String id;
  String celular;
  String departamento;
  String detalles;
  String provincia;
  String nombre;
  String zona;
  String fecha;
  String quesepara;

  factory Separador.fromJson(Map<String, dynamic> json) => Separador(
        id: json["id"],
        celular: json["celular"],
        departamento: json["departamento"],
        detalles: json["detalles"],
        provincia: json["provincia"],
        nombre: json["nombre"],
        quesepara: json["quesepara"],
        zona: json["zona"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "celular": celular,
        "departamento": departamento,
        "detalles": detalles,
        "provincia": provincia,
        "nombre": nombre,
        "quesepara": quesepara,
        "zona": zona,
        "fecha": fecha,
      };
}
