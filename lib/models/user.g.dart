// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..user_name = json['user_name'] as String
    ..phone_num = json['phone_num'] as String
    ..location_city = json['location_city'] as String
    ..location_provice = json['location_provice'] as String
    ..invite_code = json['invite_code'] as String
    ..act_time = json['act_time'] == null
        ? null
        : DateTime.parse(json['act_time'] as String)
    ..user_id = json['user_id'] as String
    ..level = json['level'] as String
    ..market_id = json['market_id'] as String
    ..wallet = json['wallet'] == null
        ? null
        : Wallet.fromJson(json['wallet'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'user_name': instance.user_name,
  'phone_num': instance.phone_num,
  'location_city': instance.location_city,
  'location_provice': instance.location_provice,
  'invite_code': instance.invite_code,
  'act_time': instance.act_time?.toIso8601String(),
  'user_id': instance.user_id,
  'market_id': instance.market_id,
  'wallet': instance.wallet,
  'level': instance.level,
};