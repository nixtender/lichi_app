// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      current: ColorNameValue.fromJson(json['current'] as Map<String, dynamic>),
      other: (json['other'] as List<dynamic>)
          .map((e) => ColorNameValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>)
          .map((e) => ProductPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'current': instance.current,
      'other': instance.other,
      'photos': instance.photos,
    };
