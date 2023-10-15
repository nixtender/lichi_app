import 'package:json_annotation/json_annotation.dart';

part 'product_photo.g.dart';

@JsonSerializable()
class ProductPhoto {
  final String big;

  ProductPhoto({required this.big});

  factory ProductPhoto.fromJson(Map<String, dynamic> json) =>
      _$ProductPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPhotoToJson(this);
}
