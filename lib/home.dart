import 'package:flutter/material.dart';
import 'login.dart';
import 'profile_page.dart';
import 'models/user_model.dart';

class Product {
  final String id;
  final String name;
  final int price;
  final String category;
  final String imageAsset;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageAsset,
    this.quantity = 0,
  });
}

class HomePage extends StatefulWidget {
  final UserAccount user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar Produk yang Menggunakan Asset Gambar Lokal
  final List<Product> _products = [
    Product(id: '1', name: 'Kopi Espresso', price: 18000, category: 'Minuman', imageAsset: 'assets/espresso.jpg'),
    Product(id: '2', name: 'Kopi Latte', price: 24000, category: 'Minuman', imageAsset: 'assets/latte.jpg'),
    Product(id: '3', name: 'Es Teh Manis', price: 6000, category: 'Minuman', imageAsset: 'assets/es_teh.jpg'),
    Product(id: '4', name: 'Roti Bakar Cokelat', price: 15000, category: 'Makanan', imageAsset: 'assets/roti_bakar.jpg'),
    Product(id: '5', name: 'Nasi Goreng Spesial', price: 28000, category: 'Makanan', imageAsset: 'assets/nasi_goreng.jpg'),
    Product(id: '6', name: 'Kentang Goreng', price: 12000, category: 'Snack', imageAsset: 'assets/kentang_goreng.jpg'),
  ];

  String _selectedCategory = 'Semua';

  String _formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  int get _totalItems => _products.fold(0, (sum, item) => sum + item.quantity);
  int get _totalPrice => _products.fold(0, (sum, item) => sum + (item.price * item.quantity));

  List<Product> get _filteredProducts {
    if (_selectedCategory == 'Semua') return _products;
    return _products.where((p) => p.category == _selectedCategory).toList();
  }

  void _incrementQty(Product product) => setState(() => product.quantity++);
  void _decrementQty(Product product) {
    setState(() {
      if (product.quantity > 0) product.quantity--;
    });
  }

  void _resetOrder() {
    setState(() {
      for (var p in _products) {
        p.quantity = 0;
      }
    });
  }

  // Dialog Konfirmasi Pembayaran
  void _processPayment() {
    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kasir: ${widget.user.nama}'),
            const SizedBox(height: 8),
            Text(
              'Total: ${_formatRupiah(_totalPrice)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text('Apakah Anda yakin ingin memproses transaksi ini?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _resetOrder();
              messenger.showSnackBar(
                const SnackBar(
                  content: Text('Pembayaran Berhasil!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
            ),
            child: const Text('BAYAR LUNAS', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Dialog Konfirmasi Logout
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin mengakhiri shift dan keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Keluar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesin Kasir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Reset Pesanan',
            onPressed: _resetOrder,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: _confirmLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Status Kasir
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.blueGrey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(user: widget.user),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFF0F172A).withValues(alpha: 0.1),
                          backgroundImage: AssetImage(widget.user.imageAsset),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Kasir: ${widget.user.nama}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Shift Aktif',
                    style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Category Chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['Semua', 'Makanan', 'Minuman', 'Snack'].map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: const Color(0xFF0F172A),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (bool selected) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // List Produk dengan Gambar Asset
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _filteredProducts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // WIDGET GAMBAR DARI ASSET
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            product.imageAsset,
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 52,
                                height: 52,
                                color: const Color(0xFF0F172A).withValues(alpha: 0.1),
                                child: const Icon(Icons.fastfood, color: Color(0xFF0F172A)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              const SizedBox(height: 2),
                              Text(_formatRupiah(product.price), style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _decrementQty(product),
                              icon: const Icon(Icons.remove_circle_outline),
                              color: product.quantity > 0 ? Colors.redAccent : Colors.grey.shade400,
                            ),
                            Text('${product.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => _incrementQty(product),
                              icon: const Icon(Icons.add_circle_outline),
                              color: const Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$_totalItems Item Dipilih', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(_formatRupiah(_totalPrice), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _totalItems > 0 ? _processPayment : null,
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text('PROSES BAYAR', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}