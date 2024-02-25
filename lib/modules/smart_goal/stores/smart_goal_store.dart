import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/smart_goal/helpers/smart_goal_helper.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'smart_goal_store.g.dart';

class SmartGoalStore = _SmartGoalStoreBase with _$SmartGoalStore;

abstract class _SmartGoalStoreBase with Store {
  late AuthStore authStore;

  _SmartGoalStoreBase({required this.authStore});

  int get userID => authStore.user!.userData.id;

  // -------------------- Loading --------------------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // -------------------- Smart Goal --------------------
  @observable
  SmartGoal smartGoal = SmartGoal(items: [], meta: SmartGoalMeta());

  // -------------------- Filtering Variable --------------------
  @observable
  SmartGoalStatusEnum filteredProgress = SmartGoalStatusEnum.all;

  @action
  void changeFilteredProgress(SmartGoalStatusEnum type) =>
      filteredProgress = type;

  // -------------------- Query Paremeter --------------------
  // Convert the value of selected filtering button to the query Paremeter
  @computed
  String get queryParemeter {
    String filter1 = SmartGoalHelper.enumToQuery[filteredProgress] ?? '';

    if ('$filter1$dateQuery'.isEmpty) {
      return '';
    }
    return '$filter1&$dateQuery';
  }

  //2024-02-29

  @observable
  DateTime? startDate = DateTime.now();

  @observable
  DateTime? endDate;

  @computed
  String get dateQuery {
    String date1 = '';
    String date2 = '';
    if (startDate != null) {
      date1 = UIHelper.getDateFormat(startDate.toString(), 'yyyy-MM-dd');
    }
    if (endDate != null) {
      date2 = UIHelper.getDateFormat(startDate.toString(), 'yyyy-MM-dd');
    }

    return 'startDate[gte]=$date1&endDate[lte]=$date2';
  }

  // -------------------- Reaction --------------------
  late ReactionDisposer _disposer;
  void setReaction() {
    _disposer = reaction((_) => queryParemeter, (value) async {
      bool refreshed = false;
      if (filteredSmartGoal[queryParemeter] == null) {
        refreshed = true;
      }
      await readByPage(refreshed: refreshed);
    });
  }

  // -------------------- Filtered SmartGoal --------------------
  // Map from a query paremeter to the SmartGoal
  @observable
  ObservableMap<String, SmartGoal> filteredSmartGoal = ObservableMap();

  @Deprecated('')
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

  // -------------------- Pagination --------------------
  @action
  void initialize() {
    if (filteredSmartGoal[queryParemeter] == null) {
      filteredSmartGoal[queryParemeter] =
          SmartGoal(items: ObservableList.of([]), meta: SmartGoalMeta());
    }
  }

  // -------------------- Read one page at a time --------------------
  @action
  Future readByPage({bool refreshed = false}) async {
    debugPrint('--> START: read smart goal');

    // initialize value of map item
    initialize();

    // if the page is refreshed, reinitialized
    if (refreshed) {
      filteredSmartGoal[queryParemeter]!.items = ObservableList();
      filteredSmartGoal[queryParemeter]!.currentPage = 0;
      setLoadingStatus(LoadingStatusEnum.loading);
    }

    // increase the page number
    filteredSmartGoal[queryParemeter]!.currentPage++;

    try {
      int page = filteredSmartGoal[queryParemeter]!.currentPage;
      Response response =
          await ApiService.dio.get('goals?$queryParemeter&page=$page');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');

        smartGoal =
            await compute(getSmartGoal, response.data as Map<String, dynamic>);

        if (filteredSmartGoal[queryParemeter]!.items.length <
            smartGoal.meta.total) {
          filteredSmartGoal[queryParemeter]!.items.addAll(smartGoal.items);
        }
        setLoadingStatus(LoadingStatusEnum.done);
      } else {
        setLoadingStatus(LoadingStatusEnum.error);
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
      }
    } catch (e) {
      setLoadingStatus(LoadingStatusEnum.error);
      debugPrint('${e.runtimeType}: ${e.toString()}');
    } finally {
      debugPrint('<-- END: read smart goal');
    }
  }

  // -------------------- Create a Smart Goal --------------------
  @action
  Future<bool> post(SmartGoalData smartGoalData) async {
    debugPrint('--> START: post, smart goal');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'goals',
        data: smartGoalData.toJson(),
      );

      if (response.statusCode == 201) {
        success = true;
        await readByPage(refreshed: true);
        setLoadingStatus(LoadingStatusEnum.done);
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        setLoadingStatus(LoadingStatusEnum.error);
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      setLoadingStatus(LoadingStatusEnum.error);
    } finally {
      debugPrint('<-- END: post, smart goal');
    }
    return success;
  }

  // -------------------- Update a Smart Goal --------------------
  @action
  Future<bool> update(SmartGoalData smartGoalData) async {
    debugPrint('--> START: update, smart goal');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response = await ApiService.dio.put(
        'goals/${smartGoalData.id}',
        data: smartGoalData.toJson(),
      );
      if (response.statusCode == 200) {
        success = true;
        await readByPage(refreshed: true);
        setLoadingStatus(LoadingStatusEnum.done);
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        setLoadingStatus(LoadingStatusEnum.error);
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      setLoadingStatus(LoadingStatusEnum.error);
    } finally {
      debugPrint('<-- END: update, smart goal');
    }
    return success;
  }

  // -------------------- Delete a Smart Goal --------------------
  @action
  Future<bool> delete(SmartGoalData smartGoalData) async {
    debugPrint('--> START: delete, smart goal');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response =
          await ApiService.dio.delete('goals/${smartGoalData.id}');
      if (response.statusCode == 200) {
        success = true;
        await readByPage(refreshed: true);
        setLoadingStatus(LoadingStatusEnum.done);
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        setLoadingStatus(LoadingStatusEnum.error);
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      setLoadingStatus(LoadingStatusEnum.error);
    } finally {
      debugPrint('<-- END: delete, smart goal');
    }
    return success;
  }

  @action
  void dispose() {
    smartGoal = SmartGoal(items: [], meta: SmartGoalMeta());
    loadingStatus = LoadingStatusEnum.none;
    _disposer();
  }
}
