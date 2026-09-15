import 'package:flutter/material.dart';
import 'user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _register() {
    String nama = _namaController.text.trim();
    String pin = _pinController.text.trim();
    String imageUrl = _imageController.text.trim();

    if (nama.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan PIN wajib diisi!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Cek apakah nama sudah terdaftar
    bool isExist = registeredUsers.any((u) => u.nama.toLowerCase() == nama.toLowerCase());
    if (isExist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama Kasir sudah terdaftar! Gunakan nama lain.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    // Gunakan avatar default jika URL kosong
    if (imageUrl.isEmpty) {
      imageUrl = 'https://i.pravatar.cc/150?img=12';
    }

    // Tambah akun baru
    registeredUsers.add(UserAccount(nama: nama, pin: pin, imageUrl: imageUrl));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil dibuat! Silakan Login.'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun Kasir', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            // Preview Foto Profil
            CircleAvatar(
              radius: 45,
              backgroundColor: const Color(0xFF0F172A).withOpacity(0.1),
              backgroundImage: _imageController.text.isNotEmpty
                  ? NetworkImage(_imageController.text)
                  : null,
              child: _imageController.text.isEmpty
                  ? const Icon(Icons.person_add, size: 40, color: Color(0xFF0F172A))
                  : null,
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Kasir Baru',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Buat PIN / ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _imageController,
              onChanged: (val) => setState(() {}), // Update preview foto
              decoration: const InputDecoration(
                labelText: 'URL Foto Profil (Opsional)',
                hintText: 'https://link-foto-anda.com/foto.jpg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.image_outlined),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                ),
                child: const Text('BUAT AKUN', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}