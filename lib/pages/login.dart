import 'package:flutter/material.dart';
import 'forgot.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_library, color: Colors.white, size: 100),
            SizedBox(height: 20),
            Text(
              "Perpustakaan Online",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void _login() {
    String id = idController.text.trim();
    String password = passwordController.text.trim();

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ID dan kata sandi wajib diisi")),
      );
      return;
    }

    if (id.toUpperCase().startsWith("ADM")) {
      print("Login sebagai Admin");
      // Navigator.push ke halaman admin
    } else {
      print("Login sebagai Anggota");
      // Navigator.push ke halaman user
    }
  }

  void _forgotPassword() {
    // Tampilkan dialog atau redirect reset password oleh admin
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Lupa Kata Sandi"),
        content: Text(
            "Silakan hubungi admin untuk mereset kata sandi Anda ke default."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tutup"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Icon(Icons.local_library, size: 80, color: Colors.indigo),
            SizedBox(height: 10),
            Text(
              "Perpustakaan Online",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: "ID Anggota / Admin",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: "Kata Sandi",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscureText = !_obscureText),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Masuk"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                );
              },
              child: Text(
                "Lupa Kata Sandi?",
                style: TextStyle(color: Colors.indigo),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
