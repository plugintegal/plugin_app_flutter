import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User {
  @JsonKey(name: "member_id")
  String memberId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "role")
  String role;
  @JsonKey(name: "avatar")
  String avatar;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "api_token")
  String apiToken;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "telegram")
  String telegram;
  @JsonKey(name: "bio")
  String bio;
  @JsonKey(name: "github")
  String github;
  @JsonKey(name: "place_of_birth")
  String placeOfBirth;
  @JsonKey(name: "date_of_birth")
  String dateOfBirth;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}