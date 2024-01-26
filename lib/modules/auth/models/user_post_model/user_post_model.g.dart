// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPost _$UserPostFromJson(Map<String, dynamic> json) => UserPost(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      passwordConfirmation: json['password_confirmation'] as String? ?? '',
    );

Map<String, dynamic> _$UserPostToJson(UserPost instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };

VerifyEmailModel _$VerifyEmailModelFromJson(Map<String, dynamic> json) =>
    VerifyEmailModel(
      email: json['email'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );

Map<String, dynamic> _$VerifyEmailModelToJson(VerifyEmailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };

UserSignIn _$UserSignInFromJson(Map<String, dynamic> json) => UserSignIn(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$UserSignInToJson(UserSignIn instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
