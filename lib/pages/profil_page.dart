import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String namaPengguna = "Thomas";
  final String idAnggota = "ID123456";

  void _showConfirmationDialog(BuildContext context, String title, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text("Apakah Anda yakin ingin melanjutkan?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text("Ya"),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(label),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Saya"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage("https://via.placeholder.com/150"),
          ),
          SizedBox(height: 10),
          Text(idAnggota, style: TextStyle(color: Colors.grey)),
          Text(namaPengguna, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(context, Icons.edit, "Edit Profil", () {
                  // Navigasi ke edit profil
                }),
                _buildMenuItem(context, Icons.support_agent, "Hubungi Admin", () {
                  // Navigasi ke form chat/kontak admin
                }),
                _buildMenuItem(context, Icons.lock_outline, "Ganti Password", () {
                  // Navigasi ke halaman ganti password
                }),
                _buildMenuItem(context, Icons.info_outline, "Mengenai Aplikasi", () {
                  showAboutDialog(
                    context: context,
                    applicationName: "Perpustakaan Digital",
                    applicationVersion: "v1.0.0",
                    applicationLegalese: "© 2025 G-One Tech",
                  );
                }),
                _buildMenuItem(context, Icons.logout, "Logout", () {
                  _showConfirmationDialog(context, "Logout", () {
                    // Proses logout
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Berhasil logout.")),
                    );
                  });
                }),
                _buildMenuItem(context, Icons.delete_forever, "Hapus Akun", () {
                  _showConfirmationDialog(context, "Hapus Akun", () {
                    // Proses hapus akun
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Akun telah dihapus.")),
                    );
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
