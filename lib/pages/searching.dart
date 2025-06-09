import 'package:flutter/material.dart';
import 'book_detail.dart'; // Jika kamu ingin menampilkan detail buku

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  TextEditingController _searchController = TextEditingController();

  List<String> allBooks = [
    "Buku A",
    "Buku B",
    "Buku C",
    "Buku D",
    "Buku E",
  ];

  List<String> filteredSuggestions = [];
  String selectedGenre = '';
  String selectedYear = '';
  int _selectedIndex = 1; // Pencarian default

  List<String> genres = ["Fiksi", "Non-Fiksi", "Sejarah", "Teknologi", "Novel"];
  List<String> years = ["2020", "2021", "2022", "2023", "2024"];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final input = _searchController.text.toLowerCase();
    setState(() {
      filteredSuggestions = allBooks
          .where((book) => book.toLowerCase().contains(input))
          .toList();
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Ganti dengan navigasi sesuai struktur aplikasimu
    // Contoh: jika 0 = Home, 2 = Riwayat, 3 = Profil
    if (index == 0) {
      Navigator.pop(context); // Kembali ke home
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSuggestionList() {
    if (_searchController.text.isEmpty || filteredSuggestions.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: filteredSuggestions
          .map((suggestion) => ListTile(
        title: Text(suggestion),
        onTap: () {
          _searchController.text = suggestion;
          setState(() {
            filteredSuggestions.clear();
          });
          // Bisa navigasi ke detail buku
        },
      ))
          .toList(),
    );
  }

  Widget _buildFilterChips(String title, List<String> options,
      String selectedValue, Function(String) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Wrap(
          spacing: 8,
          children: options
              .map((option) => ChoiceChip(
            label: Text(option),
            selected: selectedValue == option,
            onSelected: (selected) {
              setState(() {
                onSelected(selected ? option : '');
              });
            },
            selectedColor: Colors.indigo,
            backgroundColor: Colors.grey[200],
            labelStyle: TextStyle(
                color: selectedValue == option
                    ? Colors.white
                    : Colors.black),
          ))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pencarian Buku"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kolom pencarian
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari judul buku...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildSuggestionList(),
                  _buildFilterChips(
                    "📖 Berdasarkan Genre",
                    genres,
                    selectedGenre,
                        (value) => selectedGenre = value,
                  ),
                  _buildFilterChips(
                    "📅 Berdasarkan Tahun",
                    years,
                    selectedYear,
                        (value) => selectedYear = value,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
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
