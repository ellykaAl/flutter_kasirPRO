import 'package:flutter/material.dart';
import 'user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _handleSignUp() {
    String nama = _nameController.text.trim();
    String pin = _pinController.text.trim();
    String imageInput = _imageController.text.trim();

    // Validasi kosong
    if (nama.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan PIN tidak boleh kosong!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Kalau foto dikosongkan, pakai avatar lokal default dari folder assets
    if (imageInput.isEmpty) {
      imageInput = 'assets/profile.jpg'; 
    }

    // Simpan data ke memori (merujuk pada list dummyUsers di user_model.dart)
    dummyUsers.add(
      UserAccount(
        username: nama.toLowerCase().replaceAll(' ', ''), // otomatis buat username
        password: pin, // pin digunakan sebagai password
        nama: nama,
        role: 'Kasir', // set default role
        imageAsset: imageInput,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akun berhasil dibuat! Silakan masuk.'),
        backgroundColor: Colors.green,
      ),
    );

    // Kembali ke halaman Login
    Navigator.pop(context);
  }

  // --- WIDGET SISI KIRI (SAMBUTAN) ---
  Widget _buildWelcomeSide() {
    return Container(
      color: const Color(0xFF0F172A).withValues(alpha: 0.95),
      padding: const EdgeInsets.all(40.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person_add_alt_1, // Ikon tambah user
            size: 64,
            color: Colors.white,
          ),
          SizedBox(height: 24),
          Text(
            'Daftar Akun Kasir',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET SISI KANAN (FORM DAFTAR) ---
  Widget _buildFormSide(BuildContext context) {
    return Container(
      color: Colors.white.withValues(alpha: 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'BUAT AKUN',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 40),
          
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Kasir Baru',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 20),
          
          TextField(
            controller: _pinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Buat PIN / ID',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 20),
          
          TextField(
            controller: _imageController,
            decoration: const InputDecoration(
              labelText: 'Nama File Foto (Opsional, cth: assets/foto.jpg)',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.image_outlined),
            ),
          ),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'BUAT AKUN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sudah punya akun? ',
                style: TextStyle(color: Colors.black87),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Kembali ke halaman login
                },
                child: const Text(
                  'Masuk Sekarang',
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 750;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // MENGGUNAKAN GAMBAR BACKGROUND DARI ASET LOKAL
          image: DecorationImage(
            image: const AssetImage('assets/bg_cafe.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Card(
                elevation: 15,
                shadowColor: Colors.black54,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isDesktop
                    ? IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(flex: 5, child: _buildWelcomeSide()),
                            Expanded(flex: 6, child: _buildFormSide(context)),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          _buildWelcomeSide(),
                          _buildFormSide(context),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}