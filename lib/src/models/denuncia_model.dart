import 'dart:convert';

Denuncia denunciaFromJson(String str) => Denuncia.fromJson(json.decode(str));

String denunciaToJson(Denuncia data) => json.encode(data.toJson());

class Denuncia {
  Denuncia({
    this.id,
    this.idobservado,
    this.detalles,
    this.fecha,
    this.correo,
    this.aquien,
    this.correo2,
    this.tipo,
  });

  String id;
  String idobservado;
  String detalles;
  String fecha;
  String correo;
  String aquien;
  String correo2;
  String tipo;

  factory Denuncia.fromJson(Map<String, dynamic> json) => Denuncia(
        id: json["id"],
        idobservado: json["idobservado"],
        detalles: json["detalles"],
        fecha: json["fecha"],
        correo: json["correo"],
        aquien: json["aquien"],
        correo2: json["correo2"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "idobservado": idobservado,
        "detalles": detalles,
        "fecha": fecha,
        "correo": correo,
        "aquien": aquien,
        "correo2": correo2,
        "tipo": tipo,
      };
}
