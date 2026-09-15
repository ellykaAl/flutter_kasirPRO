class UserAccount {
  final String nama;
  final String pin;
  final String imageUrl;

  UserAccount({
    required this.nama,
    required this.pin,
    required this.imageUrl,
  });
}

// Database sementara di dalam memori
List<UserAccount> registeredUsers = [
  UserAccount(

    nama: 'admin',
    pin: 'admin123',
    imageUrl: 'https://images.unsplash.com/photo-1687803826915-c83a55f280b5?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Foto default
  ),
  
  UserAccount(

    nama: 'ellyka',
    pin: '1234',
    imageUrl: 'https://images.unsplash.com/photo-1722842655644-869cb12728e7?q=80&w=2021&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Foto default
  ),
];