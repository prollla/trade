import 'package:json_annotation/json_annotation.dart';

part 'orderListModel.g.dart';

@JsonSerializable()
class Order {
  int? id;
  List<OrderItem> items;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'user_phone')
  String? userPhone;
  @JsonKey(name: 'user_email')
  String? userEmail;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'delivery_id')
  String? deliveryId;
  @JsonKey(name: 'delivery_type')
  String? deliveryType;
  @JsonKey(name: 'delivery_name')
  String? deliveryName;
  @JsonKey(name: 'delivery_price')
  int? deliveryPrice;
  @JsonKey(name: 'delivery_date')
  String? deliveryDate;
  @JsonKey(name: 'payment_id')
  String? paymentId;
  @JsonKey(name: 'payment_type')
  String? paymentType;
  @JsonKey(name: 'payment_name')
  String? paymentName;
  @JsonKey(name: 'items_price')
  String? itemsPrice;
  int? discount;
  @JsonKey(name: 'full_price')
  String? fullPrice;
  String? promocode;
  String? address;
  String? comment;
  @JsonKey(name: 'error_text')
  String? errorText;
  String? brand;
  int? status;
  @JsonKey(name: 'repeated_days')
  int? repeatedDays;


  Order(
      this.id,
      this.items,
      this.userId,
      this.userName,
      this.userPhone,
      this.userEmail,
      this.createdAt,
      this.deliveryId,
      this.deliveryType,
      this.deliveryName,
      this.deliveryPrice,
      this.deliveryDate,
      this.paymentId,
      this.paymentType,
      this.paymentName,
      this.itemsPrice,
      this.discount,
      this.fullPrice,
      this.promocode,
      this.address,
      this.comment,
      this.errorText,
      this.brand,
      this.status,
      this.repeatedDays,
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  int? id;
  String name;
  String picture;
  int count;
  String price;
  int? discount;
  int order;
  int product;

  OrderItem(
      this.id,
      this.name,
      this.picture,
      this.count,
      this.price,
      this.discount,
      this.order,
      this.product,
      );

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}