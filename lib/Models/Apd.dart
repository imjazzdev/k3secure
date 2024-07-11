class ApdResponse {
  bool status;
  String message;
  Apd data;

  ApdResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApdResponse.fromJson(Map<String, dynamic> json) => ApdResponse(
        status: json["status"],
        message: json["message"],
        data: Apd.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Apd {
  String namaApd;
  String kondisiApd;
  String stokApd;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Apd({
    required this.namaApd,
    required this.kondisiApd,
    required this.stokApd,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Apd.fromJson(Map<String, dynamic> json) => Apd(
        namaApd: json["nama_apd"],
        kondisiApd: json["kondisi_apd"],
        stokApd: json["stok_apd"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama_apd": namaApd,
        "kondisi_apd": kondisiApd,
        "stok_apd": stokApd,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
