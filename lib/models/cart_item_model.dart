import 'product_model.dart';

class CartItem {
  // 1. Atribut Private
  final Product _product;
  int _quantity;

  CartItem({
    required Product product,
    int quantity = 1,
  })  : _product = product,
        _quantity = quantity;

  // 2. GETTER
  Product get product => _product;
  int get quantity => _quantity;
  
  // Fungsi Getter sekaligus mengkalkulasi total harga per item
  double get totalPrice => _product.price * _quantity;

  // 3. SETTER
  set quantity(int value) {
    if (value > 0) {
      _quantity = value;
    }
  }

  // 4. FUNCTION / METHOD PBO
  // Fungsi tambah jumlah pesanan di keranjang
  void increment() {
    // Cek dulu apakah stok produk masih mencukupi
    if (_quantity < _product.stock) {
      _quantity++;
    }
  }

  // Fungsi kurangi jumlah pesanan di keranjang
  void decrement() {
    if (_quantity > 1) {
      _quantity--;
    }
  }
}