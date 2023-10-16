import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car{
  @JsonKey(name: 'ID')
  late int id;
  @JsonKey(name: 'post_author')
  late String postAuthor;
  @JsonKey(name: 'post_date')
  late String postDate;

  Car({required this.id, required this.postAuthor,required this.postDate});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarToJson(this);
}