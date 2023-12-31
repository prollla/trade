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
      json['user_id'] as String?,
      json['user_name'] as String?,
      json['user_phone'] as String?,
      json['user_email'] as String?,
      json['created_at'] as String,
      json['delivery_id'] as String?,
      json['delivery_type'] as String?,
      json['delivery_name'] as String?,
      json['delivery_price'] as int?,
      json['delivery_date'] as String?,
      json['payment_id'] as String?,
      json['paymentType'] as String?,
      json['paymentName'] as String?,
      json['itemsPrice'] as String?,
      json['discount'] as int?,
      json['full_price'] as String?,
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
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_phone': instance.userPhone,
      'user_email': instance.userEmail,
      'created_at': instance.createdAt,
      'delivery_id': instance.deliveryId,
      'delivery_type': instance.deliveryType,
      'delivery_name': instance.deliveryName,
      'delivery_price': instance.deliveryPrice,
      'delivery_date': instance.deliveryDate,
      'payment_id': instance.paymentId,
      'paymentType': instance.paymentType,
      'paymentName': instance.paymentName,
      'itemsPrice': instance.itemsPrice,
      'discount': instance.discount,
      'full_price': instance.fullPrice,
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
