// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      email: json['email'] as String?,
      totalSteps: json['totalsteps'] as String?,
      totalKm: json['totalkm'] as String?,
      totalKcal: json['totalKcal'] as String?,
      longestDistance: json['longestdistance'] as String?,
      longestDuration: json['longestduration'] as String?,
      oki: json['oki'] as String?,
      boost: json['boost'] as String?,
      rank: json['rank'] as String?,
      expiry: json['expiry'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'totalsteps': instance.totalSteps,
      'totalkm': instance.totalKm,
      'totalKcal': instance.totalKcal,
      'longestdistance': instance.longestDistance,
      'longestduration': instance.longestDuration,
      'oki': instance.oki,
      'boost': instance.boost,
      'rank': instance.rank,
      'expiry': instance.expiry,
      'token': instance.token,
    };
