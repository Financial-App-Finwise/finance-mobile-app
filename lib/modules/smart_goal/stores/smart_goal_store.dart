import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'smart_goal_store.g.dart';

class SmartGoalStore = _SmartGoalStoreBase with _$SmartGoalStore;

abstract class _SmartGoalStoreBase with Store {
  late AuthStore authStore;

  _SmartGoalStoreBase({required this.authStore});

  int get userID => authStore.user!.userData.id;

  // ---------- Progress Status ----------
  @observable
  SmartGoalStatusEnum currentProgressStatus = SmartGoalStatusEnum.all;

  @action
  void changeProgressStatus(SmartGoalStatusEnum status) =>
      currentProgressStatus = status;

  // ---------- Data Part ----------
  @observable
  SmartGoal smartGoal = SmartGoal(data: [], meta: SmartGoalMeta());

  @computed
  ObservableList<SmartGoalData> get inProgress => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave < data.amount).toList());

  @computed
  ObservableList<SmartGoalData> get achieved => ObservableList.of(
      smartGoal.data.where((data) => data.currentSave == data.amount).toList());

  @computed
  ObservableList<SmartGoalData> get filteredGoals {
    switch (currentProgressStatus) {
      case SmartGoalStatusEnum.inProgress:
        return inProgress;
      case SmartGoalStatusEnum.achieved:
        return achieved;
      default:
        return ObservableList.of(smartGoal.data);
    }
  }

  // ---------- Loading ----------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @action
  void setStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  @action
  Future read() async {
    debugPrint('--> START: read smart goal');
    loadingStatus = LoadingStatusEnum.loading;
    try {
      Response response = await ApiService.dio.get('goals');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoal = await compute(
          getSmartGoal,
          response.data as Map<String, dynamic>,
        );
        loadingStatus = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        loadingStatus = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      loadingStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: read smart goal');
    }
  }

  // ---------- Pagination ----------
  final int _perPage = 10;

  @observable
  int currentPage = 0;

  @observable
  ObservableList<SmartGoalData> paginatedGoals = ObservableList();

  @action
  Future readByPage({bool refreshed = false}) async {
    debugPrint('--> START: read smart goal');
    if (refreshed) {
      currentPage = 0;
      paginatedGoals = ObservableList();
    }
    currentPage = currentPage + 1;
    try {
      Response response =
          await ApiService.dio.get('goals/?page=${currentPage}');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoal = await compute(
          getSmartGoal,
          response.data as Map<String, dynamic>,
        );

        // --- TODO: check if the page exceeds the last page
        print('length = ${paginatedGoals.length}');
        if (paginatedGoals.length < smartGoal.meta.total) {
          paginatedGoals.addAll(smartGoal.data);
          // paginatedGoals.sort((a, b) => b.id.compareTo(a.id));
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
      // debugPrint('${smartGoalData.toJson()}');
      // debugPrint('${FormData.fromMap(smartGoalData.toJson())}');
      Response response = await ApiService.dio.post(
        'goals',
        // data: FormData.fromMap(smartGoalData.toJson()),
        data: smartGoalData.toJson(),
      );

      if (response.statusCode == 201) {
        success = true;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
    } finally {
      debugPrint('<-- END: post, smart goal');
    }
    return success;
  }

  @action
  void dispose() {
    currentProgressStatus = SmartGoalStatusEnum.all;
    smartGoal = SmartGoal(data: [], meta: SmartGoalMeta());
    loadingStatus = LoadingStatusEnum.none;
  }
}
