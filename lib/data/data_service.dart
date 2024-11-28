import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import '../domain/models/wine.dart';
import '../domain/models/wine_type.dart';
import '../domain/models/category.dart';

class DataService {
  Future<void> loadData({
    required Function(List<Wine>) onWinesLoaded,
    required Function(List<WineType>) onWineTypesLoaded,
    required Function(List<Category>) onCategoriesLoaded,
  }) async {
    String jsonString = await rootBundle.rootBundle.loadString('assets/wines.json');
    final jsonResponse = json.decode(jsonString);

    final wines = (jsonResponse['wines'] as List)
        .map((data) => Wine.fromJson(data))
        .toList();
    final wineTypes = (jsonResponse['wineTypes'] as List)
        .map((data) => WineType.fromJson(data))
        .toList();
    final categories = (jsonResponse['categories'] as List)
        .map((data) => Category.fromJson(data))
        .toList();

    onWinesLoaded(wines);
    onWineTypesLoaded(wineTypes);
    onCategoriesLoaded(categories);
  }
}
