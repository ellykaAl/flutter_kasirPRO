class Product {
  // 1. Atribut Private
  final String _id;
  final String _name;
  final double _price;
  final String _category;
  final String _imageAsset;
  int _stock;

  Product({
    required String id,
    required String name,
    required double price,
    required String category,
    required String imageAsset,
    required int stock,
  })  : _id = id,
        _name = name,
        _price = price,
        _category = category,
        _imageAsset = imageAsset,
        _stock = stock;

  // 2. GETTER
  String get id => _id;
  String get name => _name;
  double get price => _price;
  String get category => _category;
  String get imageAsset => _imageAsset;
  int get stock => _stock;

  // 3. SETTER
  set stock(int newStock) {
    if (newStock >= 0) {
      _stock = newStock;
    }
  }

  // 4. FUNCTION / METHOD PBO
  // Fungsi mengecek apakah barang masih ada
  bool isAvailable() {
    return _stock > 0;
  }

  // Fungsi mengurangi stok saat terjadi transaksi pembelian
  bool reduceStock(int amount) {
    if (_stock >= amount) {
      _stock -= amount;
      return true; // Berhasil dikurangi
    }
    return false; // Gagal, stok tidak cukup
  }

  // Fungsi menambah stok (Restock barang dari gudang)
  void addStock(int amount) {
    if (amount > 0) {
      _stock += amount;
    }
  }
}

// Data Dummy Produk Kasir
List<Product> dummyProducts = [
  Product(id: 'p1', name: 'Espresso', price: 18000, category: 'Minuman', imageAsset: 'assets/espresso.jpg', stock: 20),
  Product(id: 'p2', name: 'Latte', price: 24000, category: 'Minuman', imageAsset: 'assets/latte.jpg', stock: 15),
  Product(id: 'p3', name: 'Es Teh', price: 8000, category: 'Minuman', imageAsset: 'assets/es_teh.jpg', stock: 50),
  Product(id: 'p4', name: 'Nasi Goreng', price: 25000, category: 'Makanan', imageAsset: 'assets/nasi_goreng.jpg', stock: 10),
  Product(id: 'p5', name: 'Kentang Goreng', price: 15000, category: 'Makanan', imageAsset: 'assets/kentang_goreng.jpg', stock: 25),
  Product(id: 'p6', name: 'Roti Bakar', price: 18000, category: 'Makanan', imageAsset: 'assets/roti_bakar.jpg', stock: 12),
];