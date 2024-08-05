class Constant {
  static const String authPrefrence = "Auth";
  static const String jwtpreference = "JWTToken";
  static const int codeTokenInvalid = 401;
  static const int codeTokenExpired = 498;

  static String USERNAME = '';
  static String NPK = '';
  static String TELP = '';
  static String EMAIL = '';
  static List DATA_USER = [];
  static bool isAdmin = false;
  static String value_path = '';
  static List<Map<String, dynamic>> DATA_PDF = [];
}

const List data_peminjaman = [
  {
    'jumlah_peminjaman': '1',
    'createdAtMonth': '07',
    'id': '1',
    'nama_apd': 'Rompi',
    'user': 'example@gmail.com',
    'createdAtYear': '2024',
    'tanggal_pengembalian': '22-07-2024',
    'tanggal_peminjaman': '22-07-2024'
  },
  {
    'jumlah_peminjaman': '2',
    'createdAtMonth': '07',
    'id': '2',
    'nama_apd': 'Penutup Telinga',
    'createdAtYear': '2024',
    'user': 'example@gmail.com',
    'tanggal_pengembalian': '23-07-2024',
    'tanggal_peminjaman': '23-07-2024'
  }
];

const List data_penggunaan = [
  {
    'createdAtMonth': '07',
    'tanggal_penggunaan': '25-07-2024',
    'nama_obat': 'Alkohol',
    'id': '1',
    'jumlah_yang_digunakan': '1',
    'user': 'example@gmail.com',
    'createdAtYear': '2024'
  },
  {
    'createdAtMonth': '07',
    'tanggal_penggunaan': '27-07-2024',
    'nama_obat': 'Alkohol',
    'id': '2',
    'jumlah_yang_digunakan': '1',
    'createdAtYear': '2024',
    'user': 'example@gmail.com'
  },
  {
    'createdAtMonth': '07',
    'tanggal_penggunaan': '27-07-2024',
    'id': '3',
    'nama_obat': 'Betadine',
    'jumlah_yang_digunakan': '1',
    'createdAtYear': '2024',
    'user': 'example@gmail.com'
  },
  {
    'createdAtMonth': '07',
    'tanggal_penggunaan': '28-07-2024',
    'id': '4',
    'nama_obat': 'Paracetamol',
    'jumlah_yang_digunakan': '1',
    'user': 'example@gmail.com',
    'createdAtYear': '2024'
  }
];
