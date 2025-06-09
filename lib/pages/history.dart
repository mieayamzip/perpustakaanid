import 'package:flutter/material.dart';
import 'review.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> readBooks = [
    {
      "judul": "Buku A",
      "pengarang": "Pengarang A",
      "cover": "https://via.placeholder.com/100x150",
      "rating": 0.0,
    },
    {
      "judul": "Buku B",
      "pengarang": "Pengarang B",
      "cover": "https://via.placeholder.com/100x150",
      "rating": 0.0,
    },
  ];

  void _handleRatingTap(int bookIndex, double rating) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewPage(
          book: readBooks[bookIndex],
          initialRating: rating,
        ),
      ),
    );

    if (result != null && result is double) {
      setState(() {
        readBooks[bookIndex]["rating"] = result;
      });
    }
  }

  Widget _buildRatingStars(double rating, int bookIndex) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      double value = i.toDouble();
      if (rating >= value) {
        stars.add(_buildStar(Icons.star, value, bookIndex));
      } else if (rating >= value - 0.5) {
        stars.add(_buildStar(Icons.star_half, value - 0.5, bookIndex));
      } else {
        stars.add(_buildStar(Icons.star_border, value, bookIndex));
      }
    }
    return Row(children: stars);
  }

  Widget _buildStar(IconData icon, double value, int bookIndex) {
    return GestureDetector(
      onTap: () => _handleRatingTap(bookIndex, value),
      child: Icon(
        icon,
        color: icon == Icons.star_border ? Colors.grey : Colors.amber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Bacaan"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: readBooks.length,
        itemBuilder: (context, index) {
          final book = readBooks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.network(book["cover"], width: 50),
              title: Text(book["judul"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book["pengarang"]),
                  SizedBox(height: 8),
                  _buildRatingStars(book["rating"], index),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
