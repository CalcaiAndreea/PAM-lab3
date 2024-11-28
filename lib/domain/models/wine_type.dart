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
