import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/settled_order_response/settled_order.dart';

part 'settled_order_array.g.dart';

@JsonSerializable()
class SettledOrderArray {
//flutter pub run build_runner build --delete-conflicting-outputs


  @JsonKey(name: "error")
  bool error;

  @JsonKey(name: "errorCode")
  String errorCode;

  @JsonKey(name: "totalSize")
  int totalSize;




  @JsonKey(name: "data")
  List<SettledOrder>? data;

  SettledOrderArray({
    required this.error,
    required this.errorCode,
    required this.totalSize,
    this.data,
  });

  factory SettledOrderArray.fromJson(Map<String, dynamic> json) => _$SettledOrderArrayFromJson(json);

  Map<String, dynamic> toJson() => _$SettledOrderArrayToJson(this);
}
