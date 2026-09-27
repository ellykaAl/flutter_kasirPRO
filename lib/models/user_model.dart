class UserAccount {
  // 1. Atribut Private (Encapsulation)
  final String _username;
  final String _password;
  String _nama;
  String _role;
  final String _imageAsset;

  UserAccount({
    required String username,
    required String password,
    required String nama,
    required String role,
    required String imageAsset,
  })  : _username = username,
        _password = password,
        _nama = nama,
        _role = role,
        _imageAsset = imageAsset;

  // 2. GETTER
  String get username => _username;
  String get password => _password;
  String get nama => _nama;
  String get role => _role;
  String get imageAsset => _imageAsset;

  // 3. SETTER
  set nama(String namaBaru) {
    if (namaBaru.trim().isNotEmpty) {
      _nama = namaBaru;
    }
  }

  // 4. FUNCTION / METHOD PBO
  // Fungsi untuk mengecek kecocokan password saat login
  bool verifyPassword(String inputPassword) {
    return _password == inputPassword;
  }

  // Fungsi untuk menaikkan/menurunkan jabatan kasir
  void updateRole(String roleBaru) {
    if (roleBaru.isNotEmpty) {
      _role = roleBaru;
    }
  }
}

// Data Dummy awal
List<UserAccount> dummyUsers = [
  UserAccount(
    username: 'kasir1',
    password: '123',
    nama: 'Ellyka GTG',
    role: 'Kasir Utama',
    imageAsset: 'assets/profile.jpg',
  ),
  UserAccount(
    username: 'kasir2',
    password: '123',
    nama: 'Bahtiar',
    role: 'kasir cadangan',
    imageAsset: 'assets/profile2.jpg',
  ),
];