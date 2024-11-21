import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle; // For loading assets

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WineShopPage());
  }
}

class WineShopPage extends StatefulWidget {
  @override
  _WineShopPageState createState() => _WineShopPageState();
}

class _WineShopPageState extends State<WineShopPage> {
  List<Wine> wines = [];
  List<WineType> wineTypes = [];
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  // Load JSON data from assets
  Future<void> loadJsonData() async {
    String jsonString =
    await rootBundle.rootBundle.loadString('assets/wines.json');
    final jsonResponse = json.decode(jsonString);

    setState(() {
      wines = (jsonResponse['wines'] as List)
          .map((data) => Wine.fromJson(data))
          .toList();
      wineTypes = (jsonResponse['wineTypes'] as List)
          .map((data) => WineType.fromJson(data))
          .toList();
      categories = (jsonResponse['categories'] as List)
          .map((data) => Category.fromJson(data))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (wines.isEmpty || wineTypes.isEmpty || categories.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location and Notification Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Location Icon and Address
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.black, size: 18),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Donnerville Drive',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '4 Donnerville Hall, Donnerville Drive, Admaston...',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF98A2B3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Notification Bell with Badge
                  Stack(
                    children: [
                      Icon(Icons.notifications_none, size: 28),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '12',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Search Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFD),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFD0D5DD)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF475467)),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF98A2B3)),
                        ),
                      ),
                    ),
                    Icon(Icons.mic, color: Color(0xFF475467)),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Shop wines by Section (Categories)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shop wines by',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2939),
                  ),
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Row(
                      children: [
                        FilterChipWidget(
                          label: category.label,
                          isSelected: category.isSelected,
                        ),
                        SizedBox(width: 12),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24),

              // Horizontal Scrollable Wine Carousel (Red, White, etc.)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: wineTypes.map((wineType) {
                    return Row(
                      children: [
                        WineTypeCard(
                          imageUrl: wineType.imageUrl,
                          wineType: wineType.wineType,
                          count: wineType.count,
                        ),
                        SizedBox(width: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24),

              // Wine List Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wine',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2939),
                    ),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFBE2C55),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Wine Cards List
              Column(
                children: wines.map((wine) {
                  return WineCard(
                    wineName: wine.wineName,
                    wineType: wine.wineType,
                    country: wine.country,
                    criticScore: wine.criticScore,
                    price: wine.price,
                    imageUrl: wine.imageUrl,
                    availability: wine.availability,
                    isFavorite: wine.isFavorite,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Filter Chip Widget for categories
class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterChipWidget({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xFFBE2C55).withOpacity(0.1)
            : Color(0xFFFCFCFD),
        border: Border.all(
            color: isSelected ? Color(0xFFBE2C55) : Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Color(0xFFBE2C55) : Color(0xFF475467),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

// Wine Type Card for the Carousel
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

// Wine Card Widget
class WineCard extends StatelessWidget {
  final String wineName;
  final String wineType;
  final String country;
  final String criticScore;
  final String price;
  final String imageUrl;
  final String availability;
  final bool isFavorite;

  const WineCard({
    required this.wineName,
    required this.wineType,
    required this.country,
    required this.criticScore,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.isFavorite,
  });

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
                  image: AssetImage(imageUrl),
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
                      availability,
                      style: TextStyle(
                        color: availability == 'Available'
                            ? Color(0xFF12B76A)
                            : Color(0xFFF53F3F),
                      ),
                    ),
                    backgroundColor: availability == 'Available'
                        ? Color(0xFFE7F9EF)
                        : Color(0xFFFDECEE),
                  ),
                  SizedBox(height: 8),
                  // Wine Name
                  Text(
                    wineName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Wine Type and Country
                  Text(wineType),
                  Text(country),
                  SizedBox(height: 8),
                  // Critic Score
                  Text('Critics\' Scores: $criticScore'),
                  SizedBox(height: 8),
                  // Price
                  Text(
                    '₹ $price',
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
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
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

// Data Models

class Wine {
  final String wineName;
  final String wineType;
  final String country;
  final String criticScore;
  final String price;
  final String imageUrl;
  final String availability;
  final bool isFavorite;

  Wine({
    required this.wineName,
    required this.wineType,
    required this.country,
    required this.criticScore,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.isFavorite,
  });

  factory Wine.fromJson(Map<String, dynamic> json) {
    return Wine(
      wineName: json['wineName'],
      wineType: json['wineType'],
      country: json['country'],
      criticScore: json['criticScore'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      availability: json['availability'],
      isFavorite: json['isFavorite'],
    );
  }
}

class WineType {
  final String imageUrl;
  final String wineType;
  final int count;

  WineType({
    required this.imageUrl,
    required this.wineType,
    required this.count,
  });

  factory WineType.fromJson(Map<String, dynamic> json) {
    return WineType(
      imageUrl: json['imageUrl'],
      wineType: json['wineType'],
      count: json['count'],
    );
  }
}

class Category {
  final String label;
  final bool isSelected;

  Category({
    required this.label,
    required this.isSelected,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      label: json['label'],
      isSelected: json['isSelected'],
    );
  }
}
