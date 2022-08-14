import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';

part 'settled_order.g.dart';

@JsonSerializable()
class SettledOrder {
//flutter pub run build_runner build --delete-conflicting-outputs

  @JsonKey(name: "settled_id")
  int settled_id;

  @JsonKey(name: "fdShopId")
  int fdShopId;

  @JsonKey(name: "fdOrder")
  List<OrderBill>? fdOrder;

  @JsonKey(name: "fdOrderKot")
  int fdOrderKot;

  @JsonKey(name: "fdOrderStatus")
  String fdOrderStatus;

  @JsonKey(name: "fdOrderType")
  String fdOrderType;

  @JsonKey(name: "netAmount")
  num netAmount;

  @JsonKey(name: "discountPersent")
  num discountPersent;

  @JsonKey(name: "discountCash")
  num discountCash;

  @JsonKey(name: "charges")
  num charges;

  @JsonKey(name: "grandTotal")
  num grandTotal;

  @JsonKey(name: "paymentType")
  String paymentType;

  @JsonKey(name: "cashReceived")
  num cashReceived;

  @JsonKey(name: "change")
  num change;

  SettledOrder(
      {required this.settled_id,
      required this.fdShopId,
      required this.fdOrder,
      required this.fdOrderKot,
      required this.fdOrderStatus,
      required this.fdOrderType,
      required this.netAmount,
      required this.discountPersent,
      required this.discountCash,
      required this.charges,
      required this.grandTotal,
      required this.paymentType,
      required this.cashReceived,
      required this.change});

  factory SettledOrder.fromJson(Map<String, dynamic> json) => _$SettledOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SettledOrderToJson(this);
}
