import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Map<String, String> book;

  const BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['judul'] ?? 'Detail Buku'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(book['cover']!, height: 200)),
            SizedBox(height: 20),
            Text(book['judul'] ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Pengarang: ${book['pengarang']}"),
            Text("Tahun Terbit: ${book['tahun']}"),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Tambah ke booking
              },
              icon: Icon(Icons.add),
              label: Text("Booking Buku Ini"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
