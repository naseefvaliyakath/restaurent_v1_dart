import 'package:json_annotation/json_annotation.dart';
import 'package:restowrent_v_two/model/room_respons/room.dart';


part 'room_response.g.dart';
@JsonSerializable()
class RoomResponse{


  @JsonKey(name : "error")
  bool error;

  @JsonKey(name : "errorCode")
  String errorCode;

  @JsonKey(name : "totalSize")
  int totalSize;



  @JsonKey(name : "data")
  List<Room>? data;




  RoomResponse(this.error, this.errorCode, this.totalSize, this.data);

  factory RoomResponse.fromJson(Map<String, dynamic> json) => _$RoomResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RoomResponseToJson(this);

}
