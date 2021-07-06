import 'dart:convert';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  Pedido({
    this.id,
    this.celular,
    this.quecosas,
    this.actor,
    this.detalles,
    this.nombre,
    this.fecha,
    this.horarios,
    this.correo,
    this.aquien,
    this.correo2,
    this.tipo,
  });

  String id;
  String celular;
  String quecosas;
  String actor;
  String detalles;
  String nombre;
  String fecha;
  String horarios;
  String correo;
  String aquien;
  String correo2;
  String tipo;

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
      id: json["id"],
      celular: json["celular"],
      quecosas: json["quecosas"],
      actor: json["actor"],
      detalles: json["detalles"],
      nombre: json["nombre"],
      fecha: json["fecha"],
      horarios: json["horarios"],
      correo: json["correo"],
      aquien: json["aquien"],
      correo2: json["correo2"],
      tipo: json["tipo"]);

  Map<String, dynamic> toJson() => {
        //"id": id,
        "celular": celular,
        "quecosas": quecosas,
        "actor": actor,
        "detalles": detalles,
        "nombre": nombre,
        "fecha": fecha,
        "horarios": horarios,
        "correo": correo,
        "aquien": aquien,
        "correo2": correo2,
        "tipo": tipo,
      };
}
