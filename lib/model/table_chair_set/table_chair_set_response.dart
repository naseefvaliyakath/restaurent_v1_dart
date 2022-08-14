import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/table_chair_set/table_chair_set.dart';


part 'table_chair_set_response.g.dart';
@JsonSerializable()
class TableChairSetResponse{


  @JsonKey(name : "error")
  bool error;

  @JsonKey(name : "errorCode")
  String errorCode;

  @JsonKey(name : "totalSize")
  int totalSize;



  @JsonKey(name : "data")
  List<TableChairSet>? data;




  TableChairSetResponse(this.error, this.errorCode, this.totalSize, this.data);

  factory TableChairSetResponse.fromJson(Map<String, dynamic> json) => _$TableChairSetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TableChairSetResponseToJson(this);

}
