class ProductModel {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final String priceString;
  final bool favorite;
  final String productType;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.priceString,
    required this.favorite,
    required this.productType,
  });

  ProductModel copyWith({
    int? id,
    String? imageUrl,
    String? name,
    double? price,
    String? priceString,
    bool? favorite,
    String? productType,
  }) {
    return ProductModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      price: price ?? this.price,
      priceString: priceString ?? this.priceString,
      favorite: favorite ?? this.favorite,
      productType: productType ?? this.productType,
    );
  }
}
