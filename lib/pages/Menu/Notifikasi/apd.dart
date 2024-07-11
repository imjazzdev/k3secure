import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k3secure/pages/Menu/Notifikasi/notifikasi_page.dart';

import '../../Widget/data_empty.dart';

class APD extends StatelessWidget {
  const APD({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('NOTIFIKASI')
              .where(
                'kategori',
                isEqualTo: 'APD',
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return const DataEmpty();
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .map((e) => CardItem(
                        nama_barang: e['nama_barang'],
                        imgPath: 'assets/apd-${e['nama_barang']}.png',
                        deskripsi: e['deskripsi'],
                        datetime: e['datetime']))
                    .toList(),
              );
            }
          }),
    );
  }
}
