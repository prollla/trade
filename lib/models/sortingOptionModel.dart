import 'package:json_annotation/json_annotation.dart';

// Запускаем генерацию кода с помощью команды:
// flutter pub run build_runner build

part 'sortingOptionModel.g.dart';

@JsonSerializable()
class SortingOption {
  final String id;
  final String name;

  SortingOption({required this.id, required this.name});

  factory SortingOption.fromJson(Map<String, dynamic> json) =>
      _$SortingOptionFromJson(json);

  // Добавляем метод для сериализации в JSON
  Map<String, dynamic> toJson() => _$SortingOptionToJson(this);
}