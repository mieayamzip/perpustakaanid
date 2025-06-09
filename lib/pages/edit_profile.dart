import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String memberId;
  final String name;
  final String currentPhone;
  final String currentEmail;

  const EditProfilePage({
    required this.memberId,
    required this.name,
    required this.currentPhone,
    required this.currentEmail,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.currentPhone);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // TODO: Kirim data ke server menggunakan http.dart
      // contoh:
      // await ApiService.put('user/update', {
      //   'phone': phone,
      //   'email': email,
      //   'password': password,
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil diperbarui')),
      );

      Navigator.pop(context); // kembali ke halaman sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ID Anggota
              Text("ID Anggota", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              TextFormField(
                initialValue: widget.memberId,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Nama
              Text("Nama", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              TextFormField(
                initialValue: widget.name,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // No Telepon
              Text("No. Telepon", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Nomor telepon wajib diisi' : null,
              ),
              SizedBox(height: 16),

              // Email
              Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Masukkan email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Email wajib diisi' : null,
              ),
              SizedBox(height: 16),

              // Password Baru
              Text("Password Baru (opsional)",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kosongkan jika tidak ingin mengubah',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Konfirmasi Password
              Text("Konfirmasi Password"),
              SizedBox(height: 4),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Ulangi password baru',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_passwordController.text.isNotEmpty &&
                      value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Simpan Perubahan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
