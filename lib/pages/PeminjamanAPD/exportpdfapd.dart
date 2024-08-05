import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k3secure/helper/saveandopendocument.dart';
import 'package:k3secure/pages/PeminjamanAPD/datapeminjamanapd_page.dart';
import 'package:k3secure/services/pdf_service.dart';

import '../../constant/constant.dart';
import '../Widget/data_empty.dart';

class ExportPdfAPD extends StatefulWidget {
  final String monthYear;

  const ExportPdfAPD({super.key, required this.monthYear});

  @override
  State<ExportPdfAPD> createState() => _ExportPdfAPDState();
}

class _ExportPdfAPDState extends State<ExportPdfAPD> {
  Future getDataFromFirestore() async {
    List<Map<String, dynamic>> dataList = [];

    try {
      // Ambil snapshot dari koleksi
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('PEMINJAMAN_APD')
          .where('createdAtMonth',
              isEqualTo: '${widget.monthYear[3]}${widget.monthYear[4]}')
          .where('createdAtYear', isEqualTo: nowYear.toString())
          .get();

      // Iterasi melalui dokumen-dokumen di snapshot
      for (var doc in querySnapshot.docs) {
        dataList.add(doc.data() as Map<String, dynamic>);
      }

      print('Data retrieved successfully.');
    } catch (e) {
      print('Error getting data: $e');
    }

    return dataList;
  }

  void fetchData() async {
    Constant.DATA_PDF = await getDataFromFirestore();
    print('DATA PEMINJAMAN:');
    print('${Constant.DATA_PDF}');
    // ignore: use_build_context_synchronously
  }

  // }
  var dataPDF;

  String nowMonth = '';
  String nowYear = '';
  String dateMonthYear = '';
  bool isLoading = false;
  getMonth() {
    if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '01') {
      nowMonth = 'January';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '02') {
      nowMonth = 'February';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '03') {
      nowMonth = 'Maret';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '04') {
      nowMonth = 'April';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '05') {
      nowMonth = 'May';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '06') {
      nowMonth = 'Juny';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '07') {
      nowMonth = 'July';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '08') {
      nowMonth = 'Agustus';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '09') {
      nowMonth = 'Septemer';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '10') {
      nowMonth = 'Oktober';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '11') {
      nowMonth = 'November';
    } else if ('${widget.monthYear[3]}${widget.monthYear[4]}' == '12') {
      nowMonth = 'Desember';
    }
    print('BULAN : $nowMonth / ${widget.monthYear[3]}${widget.monthYear[4]}');
  }

  getYear() {
    nowYear =
        '${widget.monthYear[6]}${widget.monthYear[7]}${widget.monthYear[8]}${widget.monthYear[9]}';
    print('TAHUN : $nowYear');
  }

  @override
  void initState() {
    getMonth();
    getYear();
    fetchData();
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('${nowMonth} ${nowYear}'),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('PEMINJAMAN_APD')
                  .where('createdAtMonth',
                      isEqualTo: '${widget.monthYear[3]}${widget.monthYear[4]}')
                  .where('createdAtYear', isEqualTo: nowYear.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data!.docs.isEmpty) {
                  return DataEmpty();
                } else if (snapshot.hasData == null) {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return ListView(
                      padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
                      children: snapshot.data!.docs
                          .map((e) => CardItem(
                                id: e['id'],
                                nama_apd: e['nama_apd'],
                                user: e['user'],
                                jumlah_peminjaman: e['jumlah_peminjaman'],
                                tanggal_peminjaman: e['tanggal_peminjaman'],
                                tanggal_pengembalian: e['tanggal_pengembalian'],
                              ))
                          .toList());
                }
              }),
          isLoading == false
              ? const SizedBox()
              : const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final tablePdf = await PdfService.generatePdf(
              date: '$nowMonth $nowYear', kategori: 'PEMINJAMAN APD');
          SaveAndOpenDocument.openPdf(tablePdf);

          setState(() {
            isLoading = false;
          });
        },
        child: Icon(Icons.picture_as_pdf),
        backgroundColor: Colors.red,
      ),
    );
  }
}
