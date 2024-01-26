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

  @computed
  bool get isLoading => loadingStatus == LoadingStatus.loading;

  @action
  void setLoadingStatus(LoadingStatus status) => loadingStatus = status;

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

        // user = await compute(
        //   getUserModel,
        //   response.data as Map<String, dynamic>,
        // );
        email = userPost.email;
        debugPrint('<-- END: signUp');
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint(
            '--> Error! Something went wrong, code: ${response.statusCode}');
        debugPrint('<-- END: signUp');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      debugPrint('<-- END: signUp');
      return false;
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
        debugPrint('<-- END: verifyEmail');
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint('Something went wrong, code: ${response.statusCode}');
        debugPrint('<-- END: verifyEmail');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('${e.runtimeType}: ${e.toString()}');
      debugPrint('<-- END: verifyEmail');
      return false;
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
        debugPrint('<-- END: signIn');
        return true;
      } else {
        setLoadingStatus(LoadingStatus.error);
        debugPrint(
            '--> Error! Something went wrong, code: ${response.statusCode}');
        debugPrint('<-- END: signIn');
        return false;
      }
    } catch (e) {
      setLoadingStatus(LoadingStatus.error);
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      debugPrint('<-- END: signIn');
      return false;
    }
  }

  void signOut() {
    user = null;
  }

  CacheService _cacheService = CacheService(key: 'AuthStore');

  // void writeCache() {
  //   String? value;
  //   if (user != null) {
  //     Map<String, dynamic> map = user!.toJson();
  //     try {
  //       value = jsonEncode(map);
  //     } catch (e) {
  //       debugPrint('${e.runtimeType}: ${e.toString()}');
  //     }
  //   }
  //   debugPrint('Written cache value: ${value}');
  //   // _cacheService.write(value);
  // }

  Future readCache() async {
    String? value = await _cacheService.read();
    if (value != null) {
      print(value);
      // TODO
      // user = User.fromMap();
    }
  }
}
