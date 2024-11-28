import 'package:flutter/material.dart';

class WineTypeCard extends StatelessWidget {
  final String imageUrl;
  final String wineType;
  final int count;

  const WineTypeCard({
    required this.imageUrl,
    required this.wineType,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Color(0xFFFCFCFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFD0D5DD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                imageUrl,
                width: 130,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFBE2C55),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            wineType,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2939),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
