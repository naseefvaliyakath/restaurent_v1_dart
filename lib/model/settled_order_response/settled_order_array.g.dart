// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settled_order_array.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettledOrderArray _$SettledOrderArrayFromJson(Map<String, dynamic> json) =>
    SettledOrderArray(
      error: json['error'] as bool,
      errorCode: json['errorCode'] as String,
      totalSize: json['totalSize'] as int,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SettledOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettledOrderArrayToJson(SettledOrderArray instance) =>
    <String, dynamic>{
      'error': instance.error,
      'errorCode': instance.errorCode,
      'totalSize': instance.totalSize,
      'data': instance.data,
    };
