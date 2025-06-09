import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> book;
  final double initialRating;

  ReviewPage({required this.book, required this.initialRating});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _currentRating = 0.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  Widget _buildStarRating() {
    return Wrap(
      spacing: 4,
      children: List.generate(10, (index) {
        final value = (index + 1) * 0.5;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = value;
            });
          },
          child: Icon(
            _currentRating >= value
                ? Icons.star
                : (_currentRating >= value - 0.25 ? Icons.star_half : Icons.star_border),
            color: Colors.amber,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tulis Review"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(widget.book["judul"], style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            _buildStarRating(),
            SizedBox(height: 20),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Tulis ulasanmu di sini...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _currentRating);
              },
              child: Text("Kirim Review"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
