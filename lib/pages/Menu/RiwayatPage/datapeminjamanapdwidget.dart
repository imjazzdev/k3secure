import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k3secure/Models/PeminjamanAPD.dart';
import 'package:k3secure/pages/Menu/RiwayatPage/riwayat_page.dart';

import '../../../constant/constant.dart';
import '../../Widget/data_empty.dart';

class DataPeminjamanAPDWidget extends StatelessWidget {
  const DataPeminjamanAPDWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Constant.isAdmin
            ? FirebaseFirestore.instance.collection('HISTORY_APD').snapshots()
            : FirebaseFirestore.instance
                .collection('HISTORY_APD')
                .where('user', isEqualTo: Constant.EMAIL)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.docs.isEmpty) {
            return DataEmpty();
          } else {
            // return ListView(
            //     padding: const EdgeInsets.fromLTRB(18, 25, 18, 20),
            //     children: snapshot.data!.docs
            //         .map((e) => CardItemAPD(
            //               id: e['id'],
            //               nama_apd: e['nama_apd'],
            //               user: e['user'],
            //               jumlah_peminjaman: e['jumlah_peminjaman'],
            //               tanggal_peminjaman: e['tanggal_peminjaman'],
            //               tanggal_pengembalian: e['tanggal_pengembalian'],
            //             ))
            //         .toList());
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => CardItemAPD(
                      id: snapshot.data!.docs[index]['id'],
                      nama_apd: snapshot.data!.docs[index]['nama_apd'],
                      user: snapshot.data!.docs[index]['user'],
                      jumlah_peminjaman: snapshot.data!.docs[index]
                          ['jumlah_peminjaman'],
                      tanggal_peminjaman: snapshot.data!.docs[index]
                          ['tanggal_peminjaman'],
                      tanggal_pengembalian: snapshot.data!.docs[index]
                          ['tanggal_pengembalian'],
                      id_ref: snapshot.data!.docs[index].id.toString(),
                    ));
          }
        });
  }
}
