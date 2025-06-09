// import 'package:flutter/material.dart';
// import 'pages/login.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Perpustakaan Online',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         fontFamily: 'Roboto',
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'pages/user_home.dart'; // pastikan file ini di-import
import 'pages/review.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan Online',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: UserHomePage(), // Langsung ke beranda user
    );
  }
}
