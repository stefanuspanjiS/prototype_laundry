import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> service;

  ProductDescriptionScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service['name'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              service['image'],
              width: double.infinity, // menyesuaikan lebar penuh layar
              height: 300, // Tinggi gambar tetap
              fit: BoxFit.contain, // Gambar tidak akan terpotong
            ),
            const SizedBox(height: 16),
            Text(
              service['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              service['description'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
