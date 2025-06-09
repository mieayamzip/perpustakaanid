import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'searching.dart';
import 'profil_page.dart';
import 'history.dart';// Pastikan file ini ada

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<Map<String, String>> sampleBooks = [
    {
      "cover": "https://via.placeholder.com/100x150",
      "judul": "Buku A",
      "pengarang": "Pengarang A",
      "tahun": "2020",
    },
    {
      "cover": "https://via.placeholder.com/100x150",
      "judul": "Buku B",
      "pengarang": "Pengarang B",
      "tahun": "2021",
    },
    {
      "cover": "https://via.placeholder.com/100x150",
      "judul": "Buku C",
      "pengarang": "Pengarang C",
      "tahun": "2022",
    },
  ];

  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SearchingPage()),
      );
    }
  }

  Widget _buildBookList(String title, List<Map<String, String>> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailPage(book: book),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            book["cover"]!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book["judul"]!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              Text(book["pengarang"]!,
                                  style: TextStyle(fontSize: 12)),
                              Text("Tahun: ${book["tahun"]}",
                                  style: TextStyle(fontSize: 12)),
                              SizedBox(height: 6),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Tambahkan ke daftar booking
                                },
                                icon: Icon(Icons.add),
                                label: Text("Booking"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(double.infinity, 30),
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 4),
                                  textStyle: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_library, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text("Perpustakaan Online")),
          ],
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () {
              // Navigasi ke daftar keinginan
            },
            icon: Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildBookList("📚 Buku Baru", sampleBooks),
          _buildBookList("🔥 Paling Banyak Dipinjam", sampleBooks),
          _buildBookList("⭐ Rating Tertinggi", sampleBooks),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pencarian",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Saya",
          ),
        ],
      ),
    );
  }
}
