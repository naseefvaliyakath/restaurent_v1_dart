import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';
import '../table_chair_set/table_chair_set.dart';
import 'kot_tableChairSet.dart';


part 'kitchen_order.g.dart';

@JsonSerializable()
class KitchenOrder {
//flutter pub run build_runner build --delete-conflicting-outputs

  @JsonKey(name: "Kot_id")
  int Kot_id;

  @JsonKey(name: "error")
  bool error;

  @JsonKey(name: "errorCode")
  String errorCode;

  @JsonKey(name: "totalSize")
  int totalSize;

  @JsonKey(name: "fdOrderStatus")
  String fdOrderStatus;

  @JsonKey(name: "fdOrderType")
  String fdOrderType;

  @JsonKey(name: "totelPrice")
  num totelPrice;

  @JsonKey(name: "fdOrder")
  List<OrderBill>? fdOrder;

  @JsonKey(name: "kotTableChairSet")
  List<KotTableChairSet>? kotTableChairSet;

  @JsonKey(name: "orderColor")
  int orderColor;

  KitchenOrder({
    required this.Kot_id,
    required this.error,
    required this.errorCode,
    required this.totalSize,
    this.fdOrder,
    this.kotTableChairSet,
    required this.fdOrderStatus,
    required this.fdOrderType,
    required this.totelPrice,
    required this.orderColor,
  });

  factory KitchenOrder.fromJson(Map<String, dynamic> json) => _$KitchenOrderFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenOrderToJson(this);
}
