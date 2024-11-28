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
