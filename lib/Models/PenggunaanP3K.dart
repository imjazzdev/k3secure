class PenggunaanResponse {
    bool status;
    String message;
    DataPenggunaanP3K data;

    PenggunaanResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory PenggunaanResponse.fromJson(Map<String, dynamic> json) => PenggunaanResponse(
        status: json["status"],
        message: json["message"],
        data: DataPenggunaanP3K.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class DataPenggunaanP3K {
    String npk;
    String namaObat;
    String jumlahDigunakan;
    DateTime tanggalPenggunaan;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    DataPenggunaanP3K({
        required this.npk,
        required this.namaObat,
        required this.jumlahDigunakan,
        required this.tanggalPenggunaan,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory DataPenggunaanP3K.fromJson(Map<String, dynamic> json) => DataPenggunaanP3K (
        npk: json["npk"],
        namaObat: json["nama_obat"],
        jumlahDigunakan: json["jumlah_digunakan"],
        tanggalPenggunaan: DateTime.parse(json["tanggal_penggunaan"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "npk": npk,
        "nama_obat": namaObat,
        "jumlah_digunakan": jumlahDigunakan,
        "tanggal_penggunaan": "${tanggalPenggunaan.year.toString().padLeft(4, '0')}-${tanggalPenggunaan.month.toString().padLeft(2, '0')}-${tanggalPenggunaan.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
