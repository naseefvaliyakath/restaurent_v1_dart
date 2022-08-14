import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room{

  @JsonKey(name : "room_id")
  int room_id;

  @JsonKey(name : "roomName")
  String roomName;

  @JsonKey(name : "fdShopId")
  int fdShopId;




  Room(
      this.room_id,
      this.roomName,
      this.fdShopId,
); // DateTime get getPublishedAtDate => DateTime.tryParse(publishedAt);

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}