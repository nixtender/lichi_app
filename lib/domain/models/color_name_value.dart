import 'package:json_annotation/json_annotation.dart';

part 'color_name_value.g.dart';

@JsonSerializable()
class ColorNameValue {
  final String name;
  final String value;

  ColorNameValue({required this.name, required this.value});

  factory ColorNameValue.fromJson(Map<String, dynamic> json) =>
      _$ColorNameValueFromJson(json);

  Map<String, dynamic> toJson() => _$ColorNameValueToJson(this);
}
