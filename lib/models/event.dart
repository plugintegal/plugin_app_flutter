import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(nullable: true)
class Event {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "image")
  String image;

  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}