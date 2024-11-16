import 'package:flutter/material.dart';
import 'PaymentScreen.dart';
import 'global.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Total harga dari seluruh item di keranjang
    final int totalAmount = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item['total'] as int),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['service']['name']),
                  subtitle: Text(
                    'Jumlah: ${item['quantity']}, Total: Rp ${item['total']}',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: Rp $totalAmount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke PaymentScreen dengan total harga
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(total: totalAmount),
                      ),
                    ).then((_) {
                      // Mengosongkan keranjang setelah pembayaran berhasil
                      cartItems.clear();
                      Navigator.pop(context); // Kembali ke Dashboard
                    });
                  },
                  child: const Text('Bayar Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
