import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/smart_goal/helpers/smart_goal_helper.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_detail_model.dart';
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

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  @observable
  LoadingStatusEnum loadingCreate = LoadingStatusEnum.none;

  @computed
  bool get isLoadingCreate => loadingCreate == LoadingStatusEnum.loading;

  @observable
  LoadingStatusEnum loadingUpdate = LoadingStatusEnum.none;

  @computed
  bool get isLoadingUpdate => loadingUpdate == LoadingStatusEnum.loading;

  @observable
  LoadingStatusEnum loadingYearly = LoadingStatusEnum.none;

  @computed
  bool get isLoadingYearly => loadingYearly == LoadingStatusEnum.loading;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  // -------------------- Smart Goal --------------------
  // Default
  SmartGoal get _defaultSmartGoal =>
      SmartGoal(items: ObservableList.of([]), meta: SmartGoalMeta());

  // General
  @observable
  late SmartGoal smartGoal = _defaultSmartGoal;

  // -------------------- Filter --------------------
  late final _currentDate = DateTime.now();

// endDateGTE = DateTime(store.year, index + 1);
//                 store.endDateLTE = DateTime(store.year, index + 2).subtract(
//                   const Duration(days: 1),
//                 );
  @observable
  late DateTime? endDateGTE = DateTime(
    _currentDate.year,
    _currentDate.month,
  );

  @observable
  late DateTime? endDateLTE = DateTime(
    _currentDate.year,
    _currentDate.month + 1,
  );

  @computed
  String get dateQuery {
    String endGTE = '';
    String endLT = '';
    if (endDateGTE != null) {
      endGTE = UIHelper.getDateFormat(endDateGTE.toString(), 'yyyy-MM-dd');
    }
    if (endDateLTE != null) {
      endLT = UIHelper.getDateFormat(endDateLTE.toString(), 'yyyy-MM-dd');
    }

    return 'endDate[gte]=$endGTE&endDate[lt]=$endLT';
  }

  // -------------------- Filtering Variable --------------------
  @observable
  SmartGoalStatusEnum filteredProgress = SmartGoalStatusEnum.all;

  @action
  void changeFilteredProgress(SmartGoalStatusEnum type) =>
      filteredProgress = type;

  // -------------------- Query Paremeter --------------------
  // Convert the value of selected filtering button to the query Paremeter
  // Base query parameter filter
  @computed
  String get queryParemeter {
    String progress = SmartGoalHelper.enumToQuery[filteredProgress] ?? '';

    if ('$progress$dateQuery'.isEmpty) {
      return '';
    }
    return '$progress&$dateQuery';
  }

  // Query parameter for in progress
  @computed
  String get queryParemeterInProgress {
    String progress =
        SmartGoalHelper.enumToQuery[SmartGoalStatusEnum.inProgress] ?? '';
    return dateQuery.isEmpty ? '$progress' : '$progress&$dateQuery';
  }

  // Query parameter for achieved
  @computed
  String get queryParemeterAchieved {
    String progress =
        SmartGoalHelper.enumToQuery[SmartGoalStatusEnum.achieved] ?? '';

    return dateQuery.isEmpty ? '$progress' : '$progress&$dateQuery';
  }

  // -------------------- Filtered SmartGoal --------------------
  // Map from a query paremeter to the SmartGoal
  @observable
  ObservableMap<String, SmartGoal> filteredSmartGoalMap = ObservableMap();

  // Meta data
  @observable
  SmartGoalMeta meta = SmartGoalMeta();

  // -------------------- Initialize Map Item to Avoid Null --------------------
  @action
  void initialize() {
    if (filteredSmartGoalMap[queryParemeter] == null) {
      filteredSmartGoalMap[queryParemeter] =
          SmartGoal(items: ObservableList.of([]), meta: SmartGoalMeta());
    }
  }

  // Filtered Smart Goal
  @computed
  SmartGoal get filteredSmartGoal =>
      filteredSmartGoalMap[queryParemeter] == null
          ? _defaultSmartGoal
          : filteredSmartGoalMap[queryParemeter]!;

  // Filtered in progress
  @computed
  SmartGoal get inProgressSmartGoal =>
      filteredSmartGoalMap[queryParemeterInProgress] == null
          ? _defaultSmartGoal
          : filteredSmartGoalMap[queryParemeterInProgress]!;

  // Filtered achieved
  @computed
  SmartGoal get achievedSmartGoal =>
      filteredSmartGoalMap[queryParemeterAchieved] == null
          ? _defaultSmartGoal
          : filteredSmartGoalMap[queryParemeterAchieved]!;

  // -------------------- Read --------------------
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

        meta = smartGoal.meta;

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

  // -------------------- Pagination with Filter --------------------
  late List<ReactionDisposer> _disposers;

  void setUpReaction() {
    _disposers = [
      reaction((value) => queryParemeter, (value) => initialize()),
    ];
  }

  // -------------------- Read one page at a time --------------------
  @action
  Future readByPage({
    bool refreshed = false,
    VoidCallback? setLoading,
    bool updateScreen = false,
  }) async {
    debugPrint('--> START: read smart goal');

    // check if it's required to set loading
    if (setLoading != null) {
      setLoading();
    }

    // initialize value of map item
    initialize();

    // if the page is refreshed, reinitialized
    if (refreshed) {
      filteredSmartGoalMap[queryParemeter]!.items = ObservableList();
      filteredSmartGoalMap[queryParemeter]!.currentPage = 0;
      setLoadingStatus(LoadingStatusEnum.loading);
    }

    try {
      int page = filteredSmartGoalMap[queryParemeter]!.currentPage + 1;
      Response response =
          await ApiService.dio.get('goals?$queryParemeter&page=$page');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');

        SmartGoal smartGoal = await compute(
          getSmartGoal,
          response.data as Map<String, dynamic>,
        );

        // update general smart goal
        if (updateScreen) {
          this.smartGoal = smartGoal;
        }

        if (filteredSmartGoalMap[queryParemeter]!.items.length <
            smartGoal.meta.total) {
          filteredSmartGoalMap[queryParemeter]!.items.addAll(smartGoal.items);
          // increase the page number
          filteredSmartGoalMap[queryParemeter]!.currentPage++;
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
    loadingYearly = LoadingStatusEnum.loading;
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
        loadingYearly = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        loadingYearly = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      loadingYearly = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: read smart goal');
    }
  }

  // -------------------- Show --------------------
  @observable
  SmartGoalDetailModel smartGoalDetail = SmartGoalDetailModel(
      smartGoalDetail: SmartGoalDetail(
    transactions: [],
    contributions: [],
  ));

  @observable
  LoadingStatusEnum loadingDetail = LoadingStatusEnum.none;

  @computed
  bool get isLoadingDetail => loadingDetail == LoadingStatusEnum.loading;

  @action
  Future show(int id) async {
    debugPrint('--> START: show smart goal');
    loadingDetail = LoadingStatusEnum.loading;
    try {
      Response response = await ApiService.dio.get('goals/$id');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        smartGoalDetail = await compute(
          getSmartGoalDetailModel,
          response.data as Map<String, dynamic>,
        );
        loadingDetail = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        loadingDetail = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      loadingDetail = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: show smart goal');
    }
  }

  // -------------------- Create a Smart Goal --------------------
  @action
  Future<bool> post(SmartGoalData smartGoalData) async {
    debugPrint('--> START: post, smart goal');
    loadingCreate = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'goals',
        data: smartGoalData.toJson(),
      );

      if (response.statusCode == 201) {
        success = true;
        loadingCreate = LoadingStatusEnum.done;
        await read();
        await readByPage(refreshed: true);
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        loadingCreate = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingCreate = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: post, smart goal');
    }
    return success;
  }

  // -------------------- Update a Smart Goal --------------------
  @action
  Future<bool> update(SmartGoalData smartGoalData) async {
    debugPrint('--> START: update, smart goal');
    loadingUpdate = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Response response = await ApiService.dio.put(
        'goals/${smartGoalData.id}',
        data: smartGoalData.toJson(),
      );
      if (response.statusCode == 200) {
        success = true;
        await readByPage(refreshed: true);
        loadingUpdate = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        loadingUpdate = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingUpdate = LoadingStatusEnum.error;
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
    // TODO: check dispose again...
    // smartGoal = SmartGoal(items: [], meta: SmartGoalMeta());
    loadingStatus = LoadingStatusEnum.none;
    filteredProgress = SmartGoalStatusEnum.all;
    filteredSmartGoalMap = ObservableMap();

    for (var d in _disposers) {
      d();
    }
  }
}
