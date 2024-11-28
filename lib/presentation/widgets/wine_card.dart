import 'package:flutter/material.dart';
import '../../domain/models/wine.dart';

class WineCard extends StatelessWidget {
  final Wine wine;

  const WineCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(wine.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Availability Chip
                  Chip(
                    label: Text(
                      wine.availability,
                      style: TextStyle(
                        color: wine.availability == 'Available'
                            ? Color(0xFF12B76A)
                            : Color(0xFFF53F3F),
                      ),
                    ),
                    backgroundColor: wine.availability == 'Available'
                        ? Color(0xFFE7F9EF)
                        : Color(0xFFFDECEE),
                  ),
                  SizedBox(height: 8),
                  // Wine Name
                  Text(
                    wine.wineName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Wine Type and Country
                  Text(wine.wineType),
                  Text(wine.country),
                  SizedBox(height: 8),
                  // Critic Score
                  Text('Critics\' Scores: ${wine.criticScore}'),
                  SizedBox(height: 8),
                  // Price
                  Text(
                    '₹ ${wine.price}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // Favorite Button
            IconButton(
              icon: Icon(
                wine.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: wine.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // Handle favorite button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
