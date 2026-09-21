// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

// Import file main.dart aplikasi POS kamu
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('POS Kasir App Smoke Test', (WidgetTester tester) async {
    // 1. Jalankan widget utama aplikasi
    // CATATAN: Jika nama class di lib/main.dart kamu bukan 'PosApp'
    // (misalnya 'AplikasiKasir' atau 'MyApp'), sesuaikan nama class di bawah ini.
    await tester.pumpWidget(const PosApp());

    // 2. Memastikan aplikasi berhasil memuat halaman awal (mencari judul POS KASIR SYSTEM)
    expect(find.text('POS KASIR SYSTEM'), findsOneWidget);
  });
}