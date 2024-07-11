import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k3secure/pages/Menu/Notifikasi/notifikasi_page.dart';

import '../../Widget/data_empty.dart';

class P3K extends StatelessWidget {
  const P3K({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('NOTIFIKASI')
              .where(
                'kategori',
                isEqualTo: 'P3K',
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return DataEmpty();
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => CardItem(
                        nama_barang: e['nama_barang'],
                        imgPath: 'assets/p3k-${e['nama_barang']}.png',
                        deskripsi: e['deskripsi'],
                        datetime: e['datetime']))
                    .toList(),
              );
            }
          }),
    );
  }
}
