import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

UserModel getUserModel(Map<String, dynamic> json) => UserModel.fromJson(json);

@JsonSerializable()
class UserModel {
  late String success;

  @JsonKey(name: 'api_token')
  late String apiToken;

  @JsonKey(name: 'token_type')
  late String tokenType;

  @JsonKey(name: 'data')
  late UserData userData;

  UserModel({
    this.success = '',
    this.apiToken = '',
    this.tokenType = '',
    required this.userData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserData {
  late int id;
  late String name;
  late String email;

  @JsonKey(name: 'email_verified_at')
  late String emailVerifiedAt;

  @JsonKey(name: 'email_verification_code')
  late String emailVerificationCode;

  late String totalBalance;

  @JsonKey(name: 'created_at')
  late String createdAt;

  @JsonKey(name: 'updated_at')
  late String updatedAt;

  UserData({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.emailVerifiedAt = '',
    this.emailVerificationCode = '',
    this.totalBalance = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

// {
//     "success": "true",
//     "api_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vZmlud2lzZS1hcGktdGVzdC51cC5yYWlsd2F5LmFwcC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTcwNjE3NjkyNCwiZXhwIjoxNzA2MTgwNTI0LCJuYmYiOjE3MDYxNzY5MjQsImp0aSI6Ikx6TWQ4dW9wQkxtRUsyM1ciLCJzdWIiOiIxNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ChMMEgSP7NXdULjULNEQbuzQ7z_UcwJqRCLyDohu2bE",
//     "token_type": "bearer",
//     "data": {
//         "id": 16,
//         "name": "Samedy",
//         "email": "phinsamedy@gmail.com",
//         "email_verified_at": null,
//         "email_verification_code": "8oI1LU",
//         "totalBalance": "0.00",
//         "created_at": "2024-01-25T09:48:32.000000Z",
//         "updated_at": "2024-01-25T09:48:32.000000Z"
//     }
// }
