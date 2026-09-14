import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _kasirNameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  void _handleLogin() {
    String namaKasir = _kasirNameController.text.trim();
    String pin = _pinController.text.trim();

    if (namaKasir.isNotEmpty && pin.isNotEmpty) {
      // Pindah ke Halaman Home dan hapus halaman Login dari stack/riwayat
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(namaKasir: namaKasir),
        ),
      );
    } else {
      // Tampilkan pesan kesalahan jika ada inputan yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama Kasir dan PIN/ID wajib diisi!'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Ikon POS
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.point_of_sale,
                  size: 64,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'POS KASIR SYSTEM',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Masuk untuk memulai shift kerja',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Form Input Nama Kasir
              TextField(
                controller: _kasirNameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kasir',
                  hintText: 'Contoh: Budi',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),

              // Form Input PIN / ID
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'PIN / ID Kasir',
                  hintText: 'Masukkan 4 digit PIN',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Mulai Shift
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _handleLogin,
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text(
                    'MULAI SHIFT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}