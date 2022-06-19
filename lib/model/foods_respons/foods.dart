import 'package:json_annotation/json_annotation.dart';

part 'foods.g.dart';

@JsonSerializable()
class Foods{

  @JsonKey(name : "id")
  int id;

  @JsonKey(name : "fdName")
  String fdName;

  @JsonKey(name : "fdCategory")
  String fdCategory;

  @JsonKey(name : "fdFullPrice")
  int fdFullPrice;

  @JsonKey(name : "fdThreeBiTwoPrsPrice")
  int fdThreeBiTwoPrsPrice;

  @JsonKey(name : "fdHalfPrice")
  int fdHalfPrice;

  @JsonKey(name : "fdQtrPrice")
  int fdQtrPrice;

  @JsonKey(name : "fdIsLoos")
  String fdIsLoos;

  @JsonKey(name : "cookTime")
  int cookTime;

  @JsonKey(name : "fdShopId")
  int fdShopId;

  @JsonKey(name : "fdImg")
  String fdImg;

  @JsonKey(name : "fdIsToday")
  String fdIsToday;


  Foods(
      this.id,
      this.fdName,
      this.fdCategory,
      this.fdFullPrice,
      this.fdThreeBiTwoPrsPrice,
      this.fdHalfPrice,
      this.fdQtrPrice,
      this.fdIsLoos,
      this.cookTime,
      this.fdShopId,
      this.fdImg,
      this.fdIsToday); // DateTime get getPublishedAtDate => DateTime.tryParse(publishedAt);

  factory Foods.fromJson(Map<String, dynamic> json) => _$FoodsFromJson(json);
  Map<String, dynamic> toJson() => _$FoodsToJson(this);
}