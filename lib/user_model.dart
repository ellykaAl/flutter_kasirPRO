class UserAccount {
  final String username;
  final String password;
  final String nama;
  final String role;
  final String imageAsset;

  UserAccount({
    required this.username,
    required this.password,
    required this.nama,
    required this.role,
    required this.imageAsset,
  });
}

// Data Dummy awal (Berfungsi sebagai simulasi database)
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
    role: 'kasir Cadangan',
    imageAsset: 'assets/profile2.jpg',
  )
];