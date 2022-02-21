import 'dart:convert';

class Cliente {
  Cliente({
    required this.apellido,
    required this.dni,
    required this.nombre,
    this.autos,
  });

  String apellido;
  String dni;
  String nombre;
  Map<String, Auto>? autos;

  factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        apellido: json["apellido"],
        dni: json["dni"],
        nombre: json["nombre"],
        autos: json["autos"] != null ? Map<String, Auto>.from(json["autos"].map((k, v) => MapEntry(k, Auto.fromJson(v)))) : {},
      );

  Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "dni": dni,
        "nombre": nombre,
        "autos": autos != null ? Map<String, dynamic>.from(autos!.map((key, value) => MapEntry(key, value.toJson()))) : {},
      };

  @override
  String toString() {
    return '$nombre $apellido $dni $autos';
  }

  Cliente copy() => Cliente(
        apellido: apellido,
        dni: dni,
        nombre: nombre,
        autos: autos
      );
}

////////////////////////////////////////////////////////////

class Auto {
  Auto({
    required this.marca,
    required this.modelo,
    required this.patente,
    this.historial,
  });

  String marca;
  String modelo;
  String patente;
  Map<String, Service>? historial;

  factory Auto.fromRawJson(String str) => Auto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        marca: json["marca"],
        modelo: json["modelo"],
        patente: json["patente"],
        historial: json["historial"] != null ? Map<String, Service>.from(json["historial"].map((k, v) => MapEntry(k, Service.fromJson(v)))) : {},
      );

  Map<String, dynamic> toJson() => {
        "marca": marca,
        "modelo": modelo,
        "patente": patente,
        "historial": historial != null ? Map<String, dynamic>.from(historial!.map((key, value) => MapEntry(key, value.toJson()))) : {},
      };

  @override
  String toString() {
    return '$marca $modelo $patente $historial';
  }

  Auto copy() => Auto(
        marca: marca,
        modelo: modelo,
        patente: patente,
        historial: historial,
      );
}

/////////////////////////////////////////////////////////////

class Service {
  Service({
    required this.aceite,
    required this.correa,
    required this.fecha,
    required this.filtro,
  });

  bool aceite;
  bool correa;
  String fecha;
  bool filtro;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        aceite: json["aceite"],
        correa: json["correa"],
        fecha: json["fecha"],
        filtro: json["filtro"],
      );

  Map<String, dynamic> toJson() => {
        "aceite": aceite,
        "correa": correa,
        "fecha": fecha,
        "filtro": filtro,
      };

  @override
  String toString() {
    return '$aceite $correa, $fecha, $fecha';
  }

  Service copy() => Service(
    aceite: aceite,
    correa: correa,
    fecha: fecha,
    filtro: filtro,
  );
}
