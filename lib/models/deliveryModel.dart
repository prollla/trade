import 'package:json_annotation/json_annotation.dart';

part 'deliveryModel.g.dart';

@JsonSerializable()
class Delivery {
  final String id;
  final String title;
  final String description;
  final String type;
  final String icon;
  @JsonKey(name: 'farm_address')
  final String farmAddress;

  Delivery({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    required this.farmAddress,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryToJson(this);
}
