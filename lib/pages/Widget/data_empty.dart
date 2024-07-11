import 'package:flutter/material.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset('assets/icon-empty.png'), Text('Data is empty')],
      ),
    );
  }
}
