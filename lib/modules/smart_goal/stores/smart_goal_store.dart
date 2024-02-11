import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
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
  SmartGoal smartGoal = SmartGoal(data: [], meta: SmartGoalMeta());

  @computed
  ObservableList<SmartGoalData> get inProgress => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave < data.amount).toList());

  @computed
  ObservableList<SmartGoalData> get achieved => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave == data.amount).toList());

  @observable
  LoadingStatusEnum status = LoadingStatusEnum.none;

  @action
  void setStatus(LoadingStatusEnum status) => this.status = status;

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

  // ---------- Pagination ----------
  final int _perPage = 10;

  @observable
  int currentPage = 1;

  @observable
  ObservableList<SmartGoalData> paginatedGoals = ObservableList();

  @action
  Future readByPage({bool refreshed = false}) async {
    debugPrint('--> START: read smart goal');
    if (refreshed) {
      currentPage = 1;
      paginatedGoals = ObservableList();
    }
    try {
      Response response =
          await ApiService.dio.get('goals/?page=${currentPage}');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoal = await compute(
          getSmartGoal,
          response.data as Map<String, dynamic>,
        );

        if (paginatedGoals.length < smartGoal.meta.total) {
          paginatedGoals.addAll(smartGoal.data);
          // --- TODO: check if the page exceeds the last page
        }
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
