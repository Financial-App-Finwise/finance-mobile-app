import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/smart_goal/helpers/smart_goal_helper.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_yearly_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'smart_goal_store.g.dart';

class SmartGoalStore = _SmartGoalStoreBase with _$SmartGoalStore;

abstract class _SmartGoalStoreBase with Store {
  // -------------------- Loading --------------------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

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

  late final _currentDate = DateTime.now();

  @observable
  late DateTime? startDate = DateTime(
    _currentDate.year,
    _currentDate.month,
  );

  @observable
  late DateTime? endDate = DateTime(
    _currentDate.year,
    _currentDate.month + 1,
  );

  @computed
  String get dateQuery {
    String date1 = '';
    String date2 = '';
    if (startDate != null) {
      date1 = UIHelper.getDateFormat(startDate.toString(), 'yyyy-MM-dd');
    }
    if (endDate != null) {
      date2 = UIHelper.getDateFormat(endDate.toString(), 'yyyy-MM-dd');
    }

    return 'startDate[gte]=$date1&endDate[lte]=$date2';
  }

  // -------------------- Smart Goal --------------------
  @action
  Future read({SmartGoalStatusEnum status = SmartGoalStatusEnum.all}) async {
    debugPrint('--> START: read smart goal');
    loadingStatus = LoadingStatusEnum.loading;
    try {
      Response response = await ApiService.dio
          .get('goals?${SmartGoalHelper.enumToQuery[status]}');
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

  @observable
  SmartGoal smartGoal = SmartGoal(items: [], meta: SmartGoalMeta());

  // -------------------- Filtered SmartGoal --------------------
  // Map from a query paremeter to the SmartGoal
  @observable
  ObservableMap<String, SmartGoal> filteredSmartGoal = ObservableMap();

  // -------------------- Pagination --------------------
  @action
  void initialize() {
    if (filteredSmartGoal[queryParemeter] == null) {
      filteredSmartGoal[queryParemeter] =
          SmartGoal(items: ObservableList.of([]), meta: SmartGoalMeta());
    }
  }

  late List<ReactionDisposer> _disposers;

  void setUpReaction() {
    _disposers = [
      reaction((value) => queryParemeter, (value) => initialize()),
    ];
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
          // increase the page number
          filteredSmartGoal[queryParemeter]!.currentPage++;
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

  // -------------------- Read Yearly Smart Goal --------------------
  @observable
  ObservableMap<String, SmartGoalMonth> smartGoalYearly = ObservableMap();

  @observable
  int year = DateTime.now().year;

  @action
  Future readYearly() async {
    debugPrint('--> START: read smart goal');
    loadingStatus = LoadingStatusEnum.loading;
    try {
      Response response = await ApiService.dio.get('goals?year=$year');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoalYearly = ObservableMap.of(
          await compute(
            getSmartGoalMap,
            response.data as Map<String, dynamic>,
          ),
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
    // smartGoal = SmartGoal(items: [], meta: SmartGoalMeta());
    loadingStatus = LoadingStatusEnum.none;
    filteredProgress = SmartGoalStatusEnum.all;
    filteredSmartGoal = ObservableMap();

    for (var d in _disposers) {
      d();
    }
  }
}
