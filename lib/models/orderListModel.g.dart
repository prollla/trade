// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['id'] as int?,
      (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['userId'] as String?,
      json['userName'] as String?,
      json['userPhone'] as String?,
      json['userEmail'] as String?,
      json['created_at'] as String,
      json['delivery_id'] as String?,
      json['delivery_type'] as String?,
      json['delivery_name'] as String?,
      json['deliveryPrice'] as int?,
      json['deliveryDate'] as String?,
      json['paymentId'] as String?,
      json['paymentType'] as String?,
      json['paymentName'] as String?,
      json['itemsPrice'] as String?,
      json['discount'] as int?,
      json['fullPrice'] as String?,
      json['promocode'] as String?,
      json['address'] as String?,
      json['comment'] as String?,
      json['errorText'] as String?,
      json['brand'] as String?,
      json['status'] as int?,
      json['repeatedDays'] as int?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhone': instance.userPhone,
      'userEmail': instance.userEmail,
      'createdAt': instance.createdAt,
      'deliveryId': instance.deliveryId,
      'deliveryType': instance.deliveryType,
      'deliveryName': instance.deliveryName,
      'deliveryPrice': instance.deliveryPrice,
      'deliveryDate': instance.deliveryDate,
      'paymentId': instance.paymentId,
      'paymentType': instance.paymentType,
      'paymentName': instance.paymentName,
      'itemsPrice': instance.itemsPrice,
      'discount': instance.discount,
      'fullPrice': instance.fullPrice,
      'promocode': instance.promocode,
      'address': instance.address,
      'comment': instance.comment,
      'errorText': instance.errorText,
      'brand': instance.brand,
      'status': instance.status,
      'repeatedDays': instance.repeatedDays,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['id'] as int?,
      json['name'] as String,
      json['picture'] as String,
      json['count'] as int,
      json['price'] as String,
      json['discount'] as int?,
      json['order'] as int,
      json['product'] as int,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'count': instance.count,
      'price': instance.price,
      'discount': instance.discount,
      'order': instance.order,
      'product': instance.product,
    };
