import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Tambahkan warna background jika diperlukan
        ),
        child: Center(
          child: Image.asset(
            'lib/assets/images/Laundry.png',
            fit: BoxFit.cover, // Membuat gambar memenuhi seluruh layar
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
