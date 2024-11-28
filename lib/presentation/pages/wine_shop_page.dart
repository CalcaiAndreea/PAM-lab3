import 'package:flutter/material.dart';
import '../../data/data_service.dart';
import '../../domain/models/wine.dart';
import '../../domain/models/wine_type.dart';
import '../../domain/models/category.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/wine_type_card.dart';
import '../widgets/wine_card.dart';

class WineShopPage extends StatefulWidget {
  @override
  _WineShopPageState createState() => _WineShopPageState();
}

class _WineShopPageState extends State<WineShopPage> {
  List<Wine> wines = [];
  List<WineType> wineTypes = [];
  List<Category> categories = [];
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    await dataService.loadData(
      onWinesLoaded: (loadedWines) {
        setState(() {
          wines = loadedWines;
        });
      },
      onWineTypesLoaded: (loadedWineTypes) {
        setState(() {
          wineTypes = loadedWineTypes;
        });
      },
      onCategoriesLoaded: (loadedCategories) {
        setState(() {
          categories = loadedCategories;
        });
      },
    );
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
                    wine: wine,
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
