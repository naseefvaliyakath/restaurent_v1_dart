// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KitchenOrder _$KitchenOrderFromJson(Map<String, dynamic> json) => KitchenOrder(
      id: json['_id'] as int,
      error: json['error'] as bool,
      errorCode: json['errorCode'] as String,
      totalSize: json['totalSize'] as int,
      fdOrder: (json['fdOrder'] as List<dynamic>?)
          ?.map((e) => OrderBill.fromJson(e as Map<String, dynamic>))
          .toList(),
      fdOrderStatus: json['fdOrderStatus'] as String,
      fdOrderType: json['fdOrderType'] as String,
      totelPrice: json['totelPrice'] as int,
    );

Map<String, dynamic> _$KitchenOrderToJson(KitchenOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'error': instance.error,
      'errorCode': instance.errorCode,
      'totalSize': instance.totalSize,
      'fdOrderStatus': instance.fdOrderStatus,
      'fdOrderType': instance.fdOrderType,
      'totelPrice': instance.totelPrice,
      'fdOrder': instance.fdOrder,
    };
