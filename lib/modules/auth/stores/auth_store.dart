import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/core/services/cache_service.dart';
import 'package:finwise/modules/auth/models/user_model/user_model.dart';
import 'package:finwise/modules/auth/models/user_post_model/user_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UserModel? user;

  // save user email for validation
  @observable
  String email = '';

  @observable
  LoadingStatus loadingStatus = LoadingStatus.none;

  @observable
  bool rememberMe = false;

  @computed
  bool get isLoading => loadingStatus == LoadingStatus.loading;

  @action
  void setLoadingStatus(LoadingStatus status) => loadingStatus = status;

  @action
  void toggleRememberMe() => rememberMe = !rememberMe;

  @action
  Future<bool> signUp(UserPost userPost) async {
    debugPrint('--> START: signUp');
    setLoadingStatus(LoadingStatus.loading);
    try {
      Response response = await ApiService.dio.post(
        'auth/register',
        data: FormData.fromMap(userPost.toJson()),
      );
      if (response.statusCode == 201) {
        setLoadingStatus(LoadingStatus.done);
        debugPrint('--> successfully signed up');
        debugPrint('--> data: ${response.data}');
        email = userPost.email;
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint(
            '--> Error! Something went wrong, code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      return false;
    } finally {
      debugPrint('<-- END: signUp');
    }
  }

  Future<bool> verifyEmail({required VerifyEmailModel model}) async {
    debugPrint('--> START: verifyEmail');
    setLoadingStatus(LoadingStatus.loading);
    try {
      Response response = await ApiService.dio.post(
        'auth/verify-email',
        data: FormData.fromMap(model.toJson()),
      );
      if (response.statusCode == 200) {
        setLoadingStatus(LoadingStatus.done);
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint('Something went wrong, code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('${e.runtimeType}: ${e.toString()}');
      return false;
    } finally {
      debugPrint('<-- END: verifyEmail');
    }
  }

  @action
  Future<bool> signIn(UserSignIn userSignIn) async {
    debugPrint('--> START: signIn');
    setLoadingStatus(LoadingStatus.loading);
    try {
      Response response = await ApiService.dio.post(
        'auth/login',
        data: FormData.fromMap(userSignIn.toJson()),
      );
      if (response.statusCode == 200) {
        user = await compute(
          getUserModel,
          response.data as Map<String, dynamic>,
        );
        setLoadingStatus(LoadingStatus.done);
        debugPrint('--> successfully signed In');
        debugPrint('--> data: ${response.data}');
        if (rememberMe) _writeCache();
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      return false;
    } finally {
      debugPrint('<-- END: signIn');
    }
  }

  void signOut() {
    user = null;
    _writeCache();
  }

  // Save value to cache
  CacheService _cacheService = CacheService(key: 'AuthStore');
  void _writeCache() {
    debugPrint('--> START: write cache, AuthStore');
    String? value;
    if (user != null) {
      Map<String, dynamic> map = user!.toJson();
      try {
        value = jsonEncode(map);
      } catch (e) {
        debugPrint('${e.runtimeType}: ${e.toString()}');
      }
    }
    _cacheService.write(value);
    debugPrint('--> Written cache value: ${value}');
    debugPrint('<-- END: write cache, AuthStore');
  }

  Future readCache() async {
    debugPrint('--> START: read cache, AuthStore');
    String? value = await _cacheService.read();
    debugPrint('--> read value: $value');
    if (value != null) {
      try {
        Map<String, dynamic> json = jsonDecode(value);
        debugPrint('--> read value: ${json}');
        user = UserModel.fromJson(json);
      } catch (e) {
        debugPrint('${e.runtimeType}: ${e.toString()}');
      }
    }
    debugPrint('<-- END: read cache, AuthStore');
  }
}
