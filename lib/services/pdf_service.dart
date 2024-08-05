import 'dart:io';

import 'package:flutter/material.dart';
import 'package:k3secure/constant/constant.dart';
import 'package:k3secure/pages/PeminjamanAPD/exportpdfapd.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../helper/saveandopendocument.dart';

class PdfService {
  static Future<File> generatePdf({
    required String date,
    required String kategori,
  }) async {
    final pdf = Document();

    pdf.addPage(
      pw.MultiPage(
        header: (context) => pw.Center(
          child: pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 20),
            child: pw.Text('REKAPITULASI\n${kategori} | ${date.toUpperCase()}',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
        ),
        footer: (context) => pw.Center(
          child: pw.Padding(
            padding: pw.EdgeInsets.only(top: 10),
            child: pw.Text('K3SECURE APP',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 12,
                )),
          ),
        ),
        build: (kategori == 'PENGGUNAAN P3K')
            ? (context) => [
                  pw.TableHelper.fromTextArray(
                      context: context,
                      data: <List<String>>[
                        // These will be your columns as Parameter X, Parameter Y etc.
                        <String>[
                          'ID',
                          'USER',
                          'NAMA OBAT',
                          'JUMLAH YG DIGUNAKAN',
                          'TANGGAL PENGGUNAAN',
                        ],
                        for (int i = 0; i < Constant.DATA_PDF.length; i++)
                          <String>[
                            Constant.DATA_PDF[i]['id'].toString(),
                            Constant.DATA_PDF[i]['user'],
                            Constant.DATA_PDF[i]['nama_obat'],
                            Constant.DATA_PDF[i]['jumlah_yang_digunakan']
                                .toString(),
                            Constant.DATA_PDF[i]['tanggal_penggunaan']
                                .toString(),
                          ],
                      ]),
                ]
            : (context) => [
                  pw.TableHelper
                      .fromTextArray(context: context, data: <List<String>>[
                    // These will be your columns as Parameter X, Parameter Y etc.
                    <String>[
                      'ID',
                      'USER',
                      'NAMA APD',
                      'JUMLAH PEMINJAMAN',
                      'TANGGAL PEMINJAMAN',
                      'TANGGAL PENGEMBALIAN'
                    ],
                    for (int i = 0; i < Constant.DATA_PDF.length; i++)
                      <String>[
                        Constant.DATA_PDF[i]['id'].toString(),
                        Constant.DATA_PDF[i]['user'].toString(),
                        Constant.DATA_PDF[i]['nama_apd'].toString(),
                        Constant.DATA_PDF[i]['jumlah_peminjaman'].toString(),
                        Constant.DATA_PDF[i]['tanggal_peminjaman'].toString(),
                        Constant.DATA_PDF[i]['tanggal_pengembalian'].toString(),
                      ],
                  ]),
                ],
      ),
    );

    return SaveAndOpenDocument.savePdf(nama: '${kategori}-REKAP.pdf', pdf: pdf);
  }

  static List<List<dynamic>> dataToPdf(String kategori) {
    if (kategori == 'PEMINJAMAN APD') {
      return <List<String>>[
        // These will be your columns as Parameter X, Parameter Y etc.
        <String>[
          'ID',
          'NAMA APD',
          'USER',
          'JUMLAH PEMINJAMAN',
          'TANGGAL PEMINJAMAN',
          'TANGGAL PENGEMBALIAN'
        ],
        for (int i = 0; i < data_peminjaman.length; i++)
          <String>[
            data_peminjaman[i]['id'],
            data_peminjaman[i]['nama_apd'],
            data_peminjaman[i]['user'],
            data_peminjaman[i]['jumlah_peminjaman'],
            data_peminjaman[i]['tanggal_peminjaman'],
            data_peminjaman[i]['tanggal_pengembalian'],
          ],
      ];
    } else {
      return <List<String>>[
        // These will be your columns as Parameter X, Parameter Y etc.
        <String>[
          'ID',
          'USER',
          'NAMA OBAT',
          'JUMLAH YG DIGUNAKAN',
          'TANGGAL PENGGUNAAN',
        ],
        for (int i = 0; i < data_peminjaman.length; i++)
          <String>[
            data_peminjaman[i]['id'],
            data_peminjaman[i]['user'],
            data_peminjaman[i]['nama_obat'],
            data_peminjaman[i]['jumlah_yang_digunakan'],
            data_peminjaman[i]['tanggal_penggunaan'],
          ],
      ];
    }
  }
}
