import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{

  @JsonKey(name : "CatId")
  int Catid;

  @JsonKey(name : "catName")
  String catName;

  @JsonKey(name : "fdShopId")
  int fdShopId;




  Category(
      this.Catid,
      this.catName,
      this.fdShopId,
); // DateTime get getPublishedAtDate => DateTime.tryParse(publishedAt);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}