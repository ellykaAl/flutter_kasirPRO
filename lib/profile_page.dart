import 'package:flutter/material.dart';
import 'dart:async'; // Untuk fungsi Timer durasi
import 'user_model.dart';

class ProfilePage extends StatefulWidget {
  final UserAccount user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Simulasi Waktu Login (Misal: 2 jam 15 menit yang lalu dari sekarang)
  late DateTime _loginTime;
  late Timer _timer;
  String _durationString = "00:00:00";
  
  // Simulasi Total Omzet saat shift ini
  final int _totalOmzet = 1250000;

  @override
  void initState() {
    super.initState();
    // Set waktu login simulasi
    _loginTime = DateTime.now().subtract(const Duration(hours: 2, minutes: 15));
    
    // Update durasi saat pertama kali load
    _updateDuration();
    
    // Jalankan timer setiap 1 detik untuk mengupdate durasi berjalan
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDuration();
    });
  }

  void _updateDuration() {
    final duration = DateTime.now().difference(_loginTime);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    
    if (mounted) {
      setState(() {
        _durationString = "$hours:$minutes:$seconds";
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Matikan timer saat keluar dari halaman
    super.dispose();
  }

  // Format Rupiah
  String _formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  // Format Jam Login (HH:mm)
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} WIB';
  }

  // Widget Helper untuk Kotak Info Shift
  Widget _buildShiftInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Kasir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // BACKGROUND ASET CAFE
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/bg_cafe.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), // Sedikit lebih gelap agar card menonjol
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: Colors.white, // Warna dasar card putih
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // FOTO PROFIL KASIR
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0F172A), width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xFF0F172A).withOpacity(0.1),
                      backgroundImage: AssetImage(widget.user.imageAsset),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // NAMA DAN ROLE
                  Text(
                    widget.user.nama,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.user.role,
                      style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  const Divider(),
                  
                  // INFORMASI USERNAME
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Color(0xFF0F172A)),
                    ),
                    title: const Text('Username ID', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    subtitle: Text(
                      widget.user.username,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  
                  const Divider(),
                  const SizedBox(height: 16),
                  
                  // JUDUL MANAJEMEN SHIFT
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Manajemen Shift',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // WIDGET INFO SHIFT (WAKTU, DURASI, OMZET)
                  Row(
                    children: [
                      Expanded(
                        child: _buildShiftInfoCard(
                          icon: Icons.login_rounded,
                          title: 'Waktu Login',
                          value: _formatTime(_loginTime),
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildShiftInfoCard(
                          icon: Icons.timer_outlined,
                          title: 'Durasi Shift',
                          value: _durationString,
                          color: Colors.orange.shade700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildShiftInfoCard(
                          icon: Icons.account_balance_wallet_rounded,
                          title: 'Total Omzet',
                          value: _formatRupiah(_totalOmzet),
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}