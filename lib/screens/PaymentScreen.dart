import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final int total;

  const PaymentScreen({super.key, required this.total});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _paymentController = TextEditingController();
  int _change = 0;

  void _calculateChange() {
    final paymentAmount = int.tryParse(_paymentController.text) ?? 0;
    setState(() {
      _change = paymentAmount - widget.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Pembayaran")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Transaksi: Rp ${widget.total}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _paymentController,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pembayaran',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _calculateChange(),
            ),
            const SizedBox(height: 20),
            Text(
              'Kembalian: Rp $_change',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_change >= 0) {
                  // Tampilkan dialog sukses
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Pembayaran Berhasil"),
                        content:
                            Text("Transaksi selesai. Kembalian: Rp $_change"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                              Navigator.pop(context); // Kembali ke keranjang
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Tampilkan dialog error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Pembayaran Gagal"),
                        content: const Text(
                            "Jumlah pembayaran kurang dari total transaksi."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Proses Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}
