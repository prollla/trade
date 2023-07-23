import 'package:json_annotation/json_annotation.dart';

part 'paymentMethod.g.dart';

@JsonSerializable()
class PaymentMethod {
  final String id;
  final String title;
  final String type;
  final String description;
  final String icon;
  final String? link;

  PaymentMethod({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.icon,
    this.link,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}