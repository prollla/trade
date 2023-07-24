import 'package:json_annotation/json_annotation.dart';

part 'cartModel.g.dart';

@JsonSerializable()
class Product {
  int id;
  String price;
  @JsonKey(name: 'old_price')
  String? oldPrice;
  String discount;
  String name;
  String brand;
  String picture;
  String article;
  List<Badge> badges;
  double? rating;
  int? reviewsCount;

  Product({
    required this.id,
    required this.price,
    this.oldPrice,
    required this.discount,
    required this.name,
    required this.brand,
    required this.picture,
    required this.article,
    required this.badges,
    required this.rating,
    required this.reviewsCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
@JsonSerializable()
class Badge {
  int id;
  String? textColor;
  String? bgColor;
  String? text;
  String? picture;

  Badge({
    required this.id,
    this.textColor,
    this.bgColor,
    this.text,
    this.picture,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}


@JsonSerializable()
class CartResponse {
  String price;
  @JsonKey(name: 'old_price')
  String? oldPrice;
  int count;
  List<ProductItem> products;

  CartResponse({
    required this.price,
    this.oldPrice,
    required this.count,
    required this.products,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class ProductItem {
  int count;
  Product product;

  ProductItem({
    required this.count,
    required this.product,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
