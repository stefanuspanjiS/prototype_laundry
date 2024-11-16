import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_screen.dart'; // Import halaman LoginScreen
import 'product_description_screen.dart';
import 'sales_form_screen.dart';
import 'cart_screen.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Cuci Basah',
      'price': 4000,
      'unit': 'kg',
      'image': 'lib/assets/images/cuci_basah.jpg',
      'description':
          'Layanan cuci basah adalah proses pencucian yang menggunakan air dan detergen khusus untuk membersihkan pakaian tanpa melalui proses pengeringan penuh. Pakaian yang dicuci dengan metode ini biasanya langsung dijemur atau dikeringkan dengan cara alami. Cuci basah cocok untuk pakaian sehari-hari dan jenis kain yang membutuhkan perawatan lembut.',
    },
    {
      'name': 'Cuci Kering',
      'price': 5000,
      'unit': 'kg',
      'image': 'lib/assets/images/cuci_kering.jpg',
      'description':
          'Layanan cuci kering adalah proses pencucian tanpa menggunakan air. Sebagai gantinya, bahan kimia khusus digunakan untuk membersihkan pakaian. Metode ini sangat cocok untuk pakaian yang sensitif terhadap air, seperti pakaian formal, sutra, atau wol. Cuci kering memberikan hasil yang bersih tanpa merusak struktur atau warna kain.',
    },
    {
      'name': 'Cuci + Setrika',
      'price': 7000,
      'unit': 'kg',
      'image': 'lib/assets/images/cuci_dan_setrika.jpg',
      'description':
          'Layanan ini mencakup proses pencucian dan penyetrikaan untuk memberikan hasil akhir yang rapi. Setelah pakaian dicuci bersih, pakaian akan disetrika agar bebas dari kusut dan siap untuk dipakai. Layanan ini ideal bagi pelanggan yang menginginkan pakaian langsung rapi dan siap pakai setelah proses pencucian.',
    },
    {
      'name': 'Cuci Karpet',
      'price': 16000,
      'unit': 'm²',
      'image': 'lib/assets/images/cuci_karpet.jpg',
      'description':
          'Layanan khusus ini untuk membersihkan karpet dengan teknik pencucian mendalam yang dirancang untuk mengangkat debu, kotoran, dan noda membandel. Menggunakan alat dan bahan pembersih khusus, cuci karpet membantu menjaga kebersihan dan kenyamanan karpet di rumah atau tempat kerja Anda.',
    },
  ];

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showUpdateForm(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String oldUsername = prefs.getString('registeredUsername') ??
        ''; // Ambil username lama dari SharedPreferences

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update User & Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Silakan masukkan username dan password baru Anda.',
                style: TextStyle(
                    fontSize: 14), //bisa mengatur ukuran font sesuai kebutuhan
              ),
              const SizedBox(height: 10),
              Text(
                'Username Lama: $oldUsername',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Logika untuk menyimpan username dan password
                _saveCredentials(
                    usernameController.text, passwordController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredUsername', username);
    await prefs.setString('registeredPassword', password);
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('registeredUsername');
    await prefs.remove('registeredPassword');
    await prefs.setBool('isLoggedIn', false);

    // Arahkan pengguna kembali ke layar login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn',
        false); //jika ingin ketika regist dan logout, maka data regist tidak terhapus
    //await prefs.remove('isLoggedIn'); // Menghapus status login
    //await prefs.remove('registeredUsername');
    //await prefs.remove('registeredPassword');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginScreen()), // Arahkan ke LoginScreen
    );
  }

  void _showCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sam's Laundry"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => _showCart(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'call') {
                _launchUrl('tel:+6283842562112');
              } else if (value == 'sms') {
                _launchUrl('sms:+6283842562112');
              } else if (value == 'maps') {
                _launchUrl('https://maps.google.com');
              } else if (value == 'update') {
                _showUpdateForm(context);
              } else if (value == 'logout') {
                _logout(context);
              } else if (value == 'delete_account') {
                _deleteAccount(context); // Panggil fungsi untuk hapus akun
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'call', child: Text('Call Center')),
              const PopupMenuItem(value: 'sms', child: Text('SMS Center')),
              const PopupMenuItem(value: 'maps', child: Text('Lokasi/Maps')),
              const PopupMenuItem(
                  value: 'update', child: Text('Update User & Password')),
              const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout')), // Tambahkan opsi Logout
              const PopupMenuItem(
                  value: 'delete_account',
                  child: Text('Hapus Akun')), // Tambahkan opsi Hapus Akun
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ListTile(
            leading: Image.asset(
              service['image'],
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            title: Text(service['name']),
            subtitle: Text('Harga: ${service['price']}/${service['unit']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDescriptionScreen(service: service),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalesFormScreen(service: service),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
