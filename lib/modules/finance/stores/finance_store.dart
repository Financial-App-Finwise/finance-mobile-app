import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/finance/models/finance_model.dart';
import 'package:finwise/modules/finance/models/finance_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'finance_store.g.dart';

class FinanceStore = _FinanceStoreBase with _$FinanceStore;

abstract class _FinanceStoreBase with Store {
  // -------------------- Loading --------------------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @observable
  LoadingStatusEnum barChartLoading = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // ---------- Finance ----------
  @observable
  Finance finance = Finance(
    data: FinanceData(
      items: [],
      topCategories: [],
      allTransactions: AllTransaction(today: [], yesterday: []),
      total: {},
    ),
  );

  // -------------------- Period Filter --------------------
  @observable
  int isIncome = 1;

  @observable
  String period = 'this_month';

  // -------------------- Query Paremeter --------------------
  // Convert the value of selected filtering button to the query Paremeter
  @computed
  String get queryParemeter {
    String isIncome = 'isIncome=${this.isIncome}';
    String period = 'period=${this.period}';

    // combine
    String parameter = '$isIncome&$period';

    if ('$isIncome$period'.isEmpty) {
      return '';
    }
    return '?$parameter';
  }

  // -------------------- Filtered SmartGoal --------------------
  // Map from a query paremeter to the Finance
  @observable
  ObservableMap<String, Finance> filteredFinanceMap = ObservableMap();

  // -------------------- Initialize Map Item to Avoid Null --------------------
  @action
  void initialize(String key) {
    if (filteredFinanceMap[key] == null) {
      filteredFinanceMap[key] = Finance(
        data: FinanceData(
          items: [],
          topCategories: [],
          allTransactions: AllTransaction(today: [], yesterday: []),
          total: {},
        ),
      );
    }
  }

  @computed
  String get queryParemeterIncome {
    String isIncome = 'isIncome=1';
    String period = 'period=${this.period}';

    // combine
    String parameter = '$isIncome&$period';

    if ('$isIncome$period'.isEmpty) {
      return '';
    }
    return '?$parameter';
  }

  @observable
  ObservableMap<String, IncomeExpenseCompare> previousBarData = ObservableMap();

  @computed
  String get queryParemeterExpense {
    String isIncome = 'isIncome=0';
    String period = 'period=${this.period}';

    // combine
    String parameter = '$isIncome&$period';

    if ('$isIncome$period'.isEmpty) {
      return '';
    }
    return '?$parameter';
  }

  Finance get _defaultFinance => Finance(
        data: FinanceData(
          items: [],
          topCategories: [],
          allTransactions: AllTransaction(today: [], yesterday: []),
          total: {},
        ),
      );

  @computed
  Finance get filteredFinance => filteredFinanceMap[queryParemeter] == null
      ? _defaultFinance
      : filteredFinanceMap[queryParemeter]!;

  @computed
  Finance get incomeFinance => filteredFinanceMap[queryParemeterIncome] == null
      ? _defaultFinance
      : filteredFinanceMap[queryParemeterIncome]!;

  @computed
  Finance get expenseFinance =>
      filteredFinanceMap[queryParemeterExpense] == null
          ? _defaultFinance
          : filteredFinanceMap[queryParemeterExpense]!;

  @computed
  FinanceItem get dollarAccount => filteredFinance.data.items.firstWhere(
        (element) => element.currency.code == 'USD',
        orElse: () {
          return FinanceItem(currency: Currency());
        },
      );

  @observable
  LoadingStatusEnum loadingPieChart = LoadingStatusEnum.none;

  // -------------------- Read Finance --------------------
  @action
  Future read({bool? isIncome}) async {
    debugPrint('--> START: read finance');
    loadingStatus = LoadingStatusEnum.loading;

    // check if required to load income, or expense from other screen
    if (isIncome != null) {
      this.isIncome = isIncome ? 1 : 0;
    }

    initialize(queryParemeter);

    if (filteredFinance.data.items.isEmpty) {
      barChartLoading = LoadingStatusEnum.loading;
    }

    try {
      Response response =
          await ApiService.dio.get('myfinances/view-my-finance$queryParemeter');

      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        finance = await compute(
          getFinanceModel,
          response.data as Map<String, dynamic>,
        );

        filteredFinanceMap[queryParemeter] = finance;

        if (finance.data.total.runtimeType.toString() !=
            "_Map<String, dynamic>") {
          // Map<String, dynamic> map = {};
          // map.forEach((key, value) {});
          // finance.data.total.forEach((key, value) {
          //   print('$key: $value');
          // });
        }

        loadingStatus = LoadingStatusEnum.done;
        barChartLoading = LoadingStatusEnum.done;
        loadingPieChart = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        loadingStatus = LoadingStatusEnum.error;
        barChartLoading = LoadingStatusEnum.error;
        loadingPieChart = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      loadingStatus = LoadingStatusEnum.error;
      barChartLoading = LoadingStatusEnum.error;
      loadingPieChart = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: read finance');
    }
  }

  // -------------------- Create a Finance --------------------
  @action
  Future<bool> post(FinancePost data) async {
    debugPrint('--> START: post, finance');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'myfinances',
        data: data.toJson(),
      );

      if (response.statusCode == 201) {
        success = true;
        await read();
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
      debugPrint('<-- END: post, finance');
    }
    return success;
  }

  // -------------------- Update Total Balance --------------------
  // Loading Status for Update
  @observable
  LoadingStatusEnum loadingUpdate = LoadingStatusEnum.none;

  @action
  Future<bool> update(double totalbalance) async {
    debugPrint('--> START: update, finance');
    loadingUpdate = LoadingStatusEnum.loading;

    bool success = false;
    try {
      Response response = await ApiService.dio.put(
        'myfinances/update-net-worth',
        data: {'totalbalance': totalbalance},
      );
      if (response.statusCode == 200) {
        success = true;
        loadingUpdate = LoadingStatusEnum.done;
        await read();
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
      debugPrint('<-- END: update, finance');
    }
    return success;
  }

  // -------------------- Dispose --------------------
  void dispose() {
    loadingStatus = LoadingStatusEnum.none;
    barChartLoading = LoadingStatusEnum.none;
    finance = Finance(
      data: FinanceData(
        items: [],
        topCategories: [],
        allTransactions: AllTransaction(today: [], yesterday: []),
        total: {},
      ),
    );
    period = 'this_month';
    isIncome = 1;
    filteredFinanceMap = ObservableMap();
  }
}
