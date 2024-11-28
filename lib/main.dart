import 'package:flutter/material.dart';
import 'presentation/pages/wine_shop_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WineShopPage());
  }
}
