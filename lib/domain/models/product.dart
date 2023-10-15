import 'package:json_annotation/json_annotation.dart';
import 'package:lichi_app/domain/models/color_name_value.dart';
import 'package:lichi_app/domain/models/product_photo.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final int price;
  final String description;
  final ColorNameValue current;
  final List<ColorNameValue> other;
  final List<ProductPhoto> photos;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.current,
      required this.other,
      required this.photos});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
