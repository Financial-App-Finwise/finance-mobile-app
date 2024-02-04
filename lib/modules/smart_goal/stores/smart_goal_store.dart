import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'smart_goal_store.g.dart';

class SmartGoalStore = _SmartGoalStoreBase with _$SmartGoalStore;

abstract class _SmartGoalStoreBase with Store {
  late AuthStore authStore;

  _SmartGoalStoreBase({required this.authStore});

  int get userID => authStore.user!.userData.id;

  @observable
  SmartGoal smartGoal = SmartGoal(data: []);

  @computed
  ObservableList<SmartGoalData> get inProgress => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave < data.amount).toList());

  @computed
  ObservableList<SmartGoalData> get achieved => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave == data.amount).toList());

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  void setStatus(LoadingStatus status) => this.status = status;

  @action
  Future read() async {
    debugPrint('--> START: read smart goal');
    try {
      Response response = await ApiService.dio.get('goals');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoal = await compute(
          getSmartGoal,
          response.data as Map<String, dynamic>,
        );
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
    } finally {
      debugPrint('<-- END: read smart goal');
    }
  }

  Future<bool> post(SmartGoalData smartGoalData) async {
    debugPrint('--> START: post, smart goal');
    bool success = false;
    try {
      debugPrint('${smartGoalData.toJson()}');
    } catch (e) {
    } finally {}
    return success;
  }
}
