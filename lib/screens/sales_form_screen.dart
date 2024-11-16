import 'package:flutter/material.dart';
import 'global.dart';

class SalesFormScreen extends StatefulWidget {
  final Map<String, dynamic> service;

  SalesFormScreen({required this.service});

  @override
  _SalesFormScreenState createState() => _SalesFormScreenState();
}

class _SalesFormScreenState extends State<SalesFormScreen> {
  final TextEditingController _quantityController = TextEditingController();
  int _total = 0;

  // Metode untuk menghitung total harga
  void _calculateTotal() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    setState(() {
      _total = (quantity * (widget.service['price'] as num)).toInt();
    });
  }

  // Metode untuk menambah item ke keranjang dan kembali ke DashboardScreen
  void _addToCart() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (quantity > 0) {
      // Tambahkan item ke dalam keranjang
      cartItems.add({
        'service': widget.service,
        'quantity': quantity,
        'total': _total,
      });
      Navigator.pop(context); // Kembali ke DashboardScreen
    } else {
      // Menampilkan pesan jika jumlah tidak valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Jumlah tidak valid!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Penjualan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Jumlah (${widget.service['unit']})',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _calculateTotal(),
            ),
            const SizedBox(height: 20),
            Text('Total Harga: Rp $_total'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addToCart,
              child: const Text('Masukkan ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
