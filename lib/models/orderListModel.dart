import 'package:json_annotation/json_annotation.dart';

part 'orderListModel.g.dart';

@JsonSerializable()
class Order {
  int? id;
  List<OrderItem> items;
  String? userId;
  String? userName;
  String? userPhone;
  String? userEmail;
  String createdAt;
  String? deliveryId;
  String? deliveryType;
  String? deliveryName;
  int? deliveryPrice;
  String? deliveryDate;
  String? paymentId;
  String? paymentType;
  String? paymentName;
  String? itemsPrice;
  int? discount;
  String? fullPrice;
  String? promocode;
  String? address;
  String? comment;
  String? errorText;
  String? brand;
  int? status;
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