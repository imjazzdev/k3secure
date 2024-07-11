class ObatResponse {
  bool status;
  String message;
  Obat data;

  ObatResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ObatResponse.fromJson(Map<String, dynamic> json) => ObatResponse(
        status: json["status"],
        message: json["message"],
        data: Obat.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Obat {
  String namaObat;
  String jenisObat;
  String stokObat;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Obat({
    required this.namaObat,
    required this.jenisObat,
    required this.stokObat,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        namaObat: json["nama_obat"],
        jenisObat: json["jenis_obat"],
        stokObat: json["stok_obat"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama_obat": namaObat,
        "jenis_obat": jenisObat,
        "stok_obat": stokObat,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
