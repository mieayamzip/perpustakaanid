import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController idController = TextEditingController();

  void _sendRequest() async {
    String id = idController.text.trim();

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silakan masukkan ID Anda")),
      );
      return;
    }

    final String adminPhone = "6281234567890"; // Ganti dengan nomor admin
    final String message =
    Uri.encodeFull("Halo Admin, saya ingin mereset kata sandi saya.\nID: $id");

    final Uri whatsappUrl = Uri.parse("https://wa.me/$adminPhone?text=$message");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tidak dapat membuka WhatsApp")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lupa Kata Sandi"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Masukkan ID Anda untuk mengirim permintaan reset kata sandi ke admin.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: "ID Anggota / Admin",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _sendRequest,
              icon: Icon(Icons.send),
              label: Text("Kirim Permintaan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
