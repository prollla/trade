// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delivery _$DeliveryFromJson(Map<String, dynamic> json) => Delivery(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      icon: json['icon'] as String,
      farmAddress: json['farm_address'] as String,
    );

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'icon': instance.icon,
      'farm_address': instance.farmAddress,
    };
