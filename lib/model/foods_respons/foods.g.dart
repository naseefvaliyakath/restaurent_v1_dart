// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Foods _$FoodsFromJson(Map<String, dynamic> json) => Foods(
      json['id'] as int,
      json['fdName'] as String,
      json['fdCategory'] as String,
      (json['fdFullPrice'] as num).toDouble(),
      (json['fdThreeBiTwoPrsPrice'] as num).toDouble(),
      (json['fdHalfPrice'] as num).toDouble(),
      (json['fdQtrPrice'] as num).toDouble(),
      json['fdIsLoos'] as String,
      json['cookTime'] as int,
      json['fdShopId'] as int,
      json['fdImg'] as String,
      json['fdIsToday'] as String,
    );

Map<String, dynamic> _$FoodsToJson(Foods instance) => <String, dynamic>{
      'id': instance.id,
      'fdName': instance.fdName,
      'fdCategory': instance.fdCategory,
      'fdFullPrice': instance.fdFullPrice,
      'fdThreeBiTwoPrsPrice': instance.fdThreeBiTwoPrsPrice,
      'fdHalfPrice': instance.fdHalfPrice,
      'fdQtrPrice': instance.fdQtrPrice,
      'fdIsLoos': instance.fdIsLoos,
      'cookTime': instance.cookTime,
      'fdShopId': instance.fdShopId,
      'fdImg': instance.fdImg,
      'fdIsToday': instance.fdIsToday,
    };
