import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/foods_respons/foods.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';

part 'kitchen_order.g.dart';

@JsonSerializable()
class KitchenOrder {
//flutter pub run build_runner build --delete-conflicting-outputs

  @JsonKey(name: "_id")
  int id;

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
  int totelPrice;

  @JsonKey(name: "fdOrder")
  List<OrderBill>? fdOrder;

  KitchenOrder({
    required this.id,
    required this.error,
    required this.errorCode,
    required this.totalSize,
    this.fdOrder,
    required this.fdOrderStatus,
    required this.fdOrderType,
    required this.totelPrice,
  });

  factory KitchenOrder.fromJson(Map<String, dynamic> json) => _$KitchenOrderFromJson(json);

  Map<String, dynamic> toJson() => _$KitchenOrderToJson(this);
}
