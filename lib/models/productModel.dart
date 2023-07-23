import 'package:json_annotation/json_annotation.dart';

part 'productModel.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? price;
  double? discount;
  String? oldPrice;
  String? name;
  String? article;
  String? picture;
  double? rating;
  int? reviewsCount;
  String? brand;
  List<Badge> badges;

  Product({
    this.id,
    this.price,
    this.discount,
    this.oldPrice,
    this.name,
    this.article,
    this.picture,
    this.rating,
    this.reviewsCount,
    required this.brand,
    required this.badges,
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
class ApiResponse {
  int? count;
  dynamic next;
  dynamic previous;
  List<Product> results;

  ApiResponse({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}


