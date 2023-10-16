import 'package:json_annotation/json_annotation.dart';
import 'package:lichi_app/domain/models/db_model.dart';

part 'product_base.g.dart';

@JsonSerializable()
class ProductBase implements DbModel {
  @override
  int id;
  String name;
  int price;
  String description;
  String currentValueColor;
  String photo;
  int count;

  ProductBase(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.currentValueColor,
      required this.photo,
      required this.count});

  factory ProductBase.fromJson(Map<String, dynamic> json) =>
      _$ProductBaseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductBaseToJson(this);

  @override
  Map<String, dynamic> toMap() => _$ProductBaseToJson(this);

  factory ProductBase.fromMap(Map<String, dynamic> map) =>
      _$ProductBaseFromJson(map);
}
