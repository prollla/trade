// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      price: json['price'] as String,
      oldPrice: json['old_price'] as String?,
      discount: json['discount'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      picture: json['picture'] as String,
      article: json['article'] as String,
      badges: (json['badges'] as List<dynamic>)
          .map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviewsCount'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'old_price': instance.oldPrice,
      'discount': instance.discount,
      'name': instance.name,
      'brand': instance.brand,
      'picture': instance.picture,
      'article': instance.article,
      'badges': instance.badges,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as int,
      textColor: json['textColor'] as String?,
      bgColor: json['bgColor'] as String?,
      text: json['text'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'textColor': instance.textColor,
      'bgColor': instance.bgColor,
      'text': instance.text,
      'picture': instance.picture,
    };

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      price: json['price'] as String,
      oldPrice: json['old_price'] as String?,
      count: json['count'] as int,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'price': instance.price,
      'old_price': instance.oldPrice,
      'count': instance.count,
      'products': instance.products,
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      count: json['count'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'count': instance.count,
      'product': instance.product,
    };
