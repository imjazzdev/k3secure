class PeminjamanResponse {
  bool status;
  String message;
  DataPeminjaman data;

  PeminjamanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PeminjamanResponse.fromJson(Map<String, dynamic> json) => PeminjamanResponse(
        status: json["status"],
        message: json["message"],
        data: DataPeminjaman.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DataPeminjaman {
  String npk;
  String namaApd;
  String jumlahDipinjam;
  DateTime tanggalPeminjaman;
  DateTime tanggalPengembalian;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  DataPeminjaman({
    required this.npk,
    required this.namaApd,
    required this.jumlahDipinjam,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DataPeminjaman.fromJson(Map<String, dynamic> json) => DataPeminjaman(
        npk: json["npk"],
        namaApd: json["nama_apd"],
        jumlahDipinjam: json["jumlah_dipinjam"],
        tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
        tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "npk": npk,
        "nama_apd": namaApd,
        "jumlah_dipinjam": jumlahDipinjam,
        "tanggal_peminjaman":
            "${tanggalPeminjaman.year.toString().padLeft(4, '0')}-${tanggalPeminjaman.month.toString().padLeft(2, '0')}-${tanggalPeminjaman.day.toString().padLeft(2, '0')}",
        "tanggal_pengembalian":
            "${tanggalPengembalian.year.toString().padLeft(4, '0')}-${tanggalPengembalian.month.toString().padLeft(2, '0')}-${tanggalPengembalian.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
