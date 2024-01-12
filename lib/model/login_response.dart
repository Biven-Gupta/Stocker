import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? code;
  String? message;
  Data? data;

  LoginResponse({this.code, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  String toString() {
    return 'LoginResponse{code: $code, message: $message, data: $data}';
  }
}

@JsonSerializable()
class Data {
  String? id;
  String? email;
  @JsonKey(name: "totalsteps")
  String? totalSteps;
  @JsonKey(name: "totalkm")
  String? totalKm;
  @JsonKey(name: "totalKcal")
  String? totalKcal;
  @JsonKey(name: "longestdistance")
  String? longestDistance;
  @JsonKey(name: "longestduration")
  String? longestDuration;
  String? oki;
  String? boost;
  String? rank;
  String? expiry;
  String? token;

  Data({this.id, this.email, this.totalSteps, this.totalKm, this.totalKcal, this.longestDistance, this.longestDuration, this.oki, this.boost, this.rank, this.expiry, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  @override
  String toString() {
    return 'Data{id: $id, email: $email, totalSteps: $totalSteps, totalKm: $totalKm, totalKcal: $totalKcal, longestDistance: $longestDistance, longestDuration: $longestDuration, oki: $oki, boost: $boost, rank: $rank, expiry: $expiry, token: $token}';
  }
}
