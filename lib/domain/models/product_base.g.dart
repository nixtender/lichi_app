// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBase _$ProductBaseFromJson(Map<String, dynamic> json) => ProductBase(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      currentValueColor: json['currentValueColor'] as String,
      photo: json['photo'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$ProductBaseToJson(ProductBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'currentValueColor': instance.currentValueColor,
      'photo': instance.photo,
      'count': instance.count,
    };
