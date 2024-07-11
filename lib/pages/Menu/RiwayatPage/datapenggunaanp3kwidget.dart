import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:k3secure/pages/Menu/RiwayatPage/riwayat_page.dart';

import '../../../constant/constant.dart';
import '../../Widget/data_empty.dart';

class DataPenggunaanP3KWidget extends StatelessWidget {
  late DocumentReference _documentReference;
  late Future<DocumentSnapshot> _futureDocument;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Constant.isAdmin
            ? FirebaseFirestore.instance.collection('HISTORY_P3K').snapshots()
            : FirebaseFirestore.instance
                .collection('HISTORY_P3K')
                .where('user', isEqualTo: Constant.EMAIL)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.docs.isEmpty) {
            return const DataEmpty();
          } else {
            // return ListView(
            //     padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
            //     children: snapshot.data!.docs
            //         .map((e) => CardItemP3K(
            //             id: e['id'],
            //             nama_obat: e['nama_obat'],
            //             user: e['user'],
            //             jumlah_yang_digunakan: e['jumlah_yang_digunakan'],
            //             tanggal_penggunaan: e['tanggal_penggunaan'],
            //             onDelete: () async {
            //               await FirebaseFirestore.instance
            //                   .collection('HISTORY_P3K')
            //                   .doc(
            //                     snapshot.data!.docs.
            //                   )
            //                   .delete();
            //             }))
            //         .toList());
            return ListView.builder(
                padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CardItemP3K(
                      nama_obat: snapshot.data!.docs[index]['nama_obat'],
                      user: snapshot.data!.docs[index]['user'],
                      tanggal_penggunaan: snapshot.data!.docs[index]
                          ['tanggal_penggunaan'],
                      id: snapshot.data!.docs[index]['id'],
                      jumlah_yang_digunakan: snapshot.data!.docs[index]
                          ['jumlah_yang_digunakan'],
                      id_ref: snapshot.data!.docs[index].id.toString(),
                    ));
          }
        });
  }
}
