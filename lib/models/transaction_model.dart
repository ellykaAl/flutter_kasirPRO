import 'cart_item_model.dart';

class TransactionModel {
  // 1. Atribut Private
  final String _id;
  final List<CartItem> _items;
  final double _totalAmount;
  final DateTime _timestamp;
  final String _cashierName;

  TransactionModel({
    required String id,
    required List<CartItem> items,
    required double totalAmount,
    required DateTime timestamp,
    required String cashierName,
  })  : _id = id,
        _items = items,
        _totalAmount = totalAmount,
        _timestamp = timestamp,
        _cashierName = cashierName;

  // 2. GETTER (Struk transaksi biasanya read-only, jadi tidak perlu Setter)
  String get id => _id;
  List<CartItem> get items => _items;
  double get totalAmount => _totalAmount;
  DateTime get timestamp => _timestamp;
  String get cashierName => _cashierName;

  // 3. FUNCTION / METHOD PBO
  // Fungsi untuk menghitung total kuantitas barang dalam 1 transaksi
  int getTotalItems() {
    int total = 0;
    for (var item in _items) {
      total += item.quantity;
    }
    return total;
  }

  // Fungsi untuk mencetak ringkasan struk kasir
  String generateReceiptSummary() {
    return 'ID Transaksi: $_id\n'
           'Kasir: $_cashierName\n'
           'Total Item: ${getTotalItems()} pcs\n'
           'Total Bayar: Rp $_totalAmount';
  }
}