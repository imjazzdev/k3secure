class NotifikasiModel {
  final String nama_barang, deskripsi, datetime, kategori;

  NotifikasiModel(
      {required this.nama_barang,
      required this.deskripsi,
      required this.datetime,
      required this.kategori});

  Map<String, dynamic> toJson() => {
        'nama_barang': nama_barang,
        'deskripsi': deskripsi,
        'datetime': datetime,
        'kategori': kategori
      };
}
