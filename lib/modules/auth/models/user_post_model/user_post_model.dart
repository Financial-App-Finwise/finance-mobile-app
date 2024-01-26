import 'package:json_annotation/json_annotation.dart';

part 'user_post_model.g.dart';

@JsonSerializable()
class UserPost {
  late String name;
  late String email;
  late String password;

  @JsonKey(name: 'password_confirmation')
  late String passwordConfirmation;

  UserPost({
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
  });

  Map<String, dynamic> toJson() => _$UserPostToJson(this);
}

@JsonSerializable()
class VerifyEmailModel {
  late String email;
  late String code;

  VerifyEmailModel({
    this.email = '',
    this.code = '',
  });

  Map<String, dynamic> toJson() => _$VerifyEmailModelToJson(this);
}

@JsonSerializable()
class UserSignIn {
  late String email;
  late String password;

  UserSignIn({
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toJson() => _$UserSignInToJson(this);
 }
