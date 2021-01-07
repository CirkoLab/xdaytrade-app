import 'package:json_annotation/json_annotation.dart';
import "wallet.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String user_name;
    String phone_num;
    String location_city;
    String location_provice;
    String invite_code;
    DateTime act_time;
    String user_id;
    String market_id;
    Wallet wallet;
    String level;



    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}