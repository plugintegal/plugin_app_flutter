// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..memberId = json['member_id'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..role = json['role'] as String
    ..avatar = json['avatar'] as String
    ..status = json['status'] as String
    ..apiToken = json['api_token'] as String
    ..username = json['username'] as String
    ..phone = json['phone'] as String
    ..telegram = json['telegram'] as String
    ..bio = json['bio'] as String
    ..github = json['github'] as String
    ..placeOfBirth = json['place_of_birth'] as String
    ..dateOfBirth = json['date_of_birth'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'member_id': instance.memberId,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'avatar': instance.avatar,
      'status': instance.status,
      'api_token': instance.apiToken,
      'username': instance.username,
      'phone': instance.phone,
      'telegram': instance.telegram,
      'bio': instance.bio,
      'github': instance.github,
      'place_of_birth': instance.placeOfBirth,
      'date_of_birth': instance.dateOfBirth,
    };
