import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/finance/helpers/finance_filter_constant.dart';
import 'package:finwise/modules/finance/models/finance_model.dart';
import 'package:finwise/modules/finance/models/finance_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'finance_store.g.dart';

class FinanceStore = _FinanceStoreBase with _$FinanceStore;

abstract class _FinanceStoreBase with Store {
  // **************************************************************************
  // Loading
  // **************************************************************************
  // -------------------- General --------------------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // -------------------- Bar Chart --------------------
  @observable
  LoadingStatusEnum loadingBarChart = LoadingStatusEnum.none;

  @computed
  bool get isLoadingBarChart => loadingBarChart == LoadingStatusEnum.loading;

  // -------------------- Pie Chart --------------------
  @observable
  LoadingStatusEnum loadingPieChart = LoadingStatusEnum.none;

  @computed
  bool get isLoadingPieChart => loadingPieChart == LoadingStatusEnum.loading;

  // -------------------- Update Balance --------------------
  @observable
  LoadingStatusEnum loadingUpdate = LoadingStatusEnum.none;

  @computed
  bool get isLoadingUpdate => loadingUpdate == LoadingStatusEnum.loading;

  // **************************************************************************
  // Finance
  // **************************************************************************
  // -------------------- Default --------------------
  Finance get _defaultFinance => Finance(
        data: FinanceData(
          items: [],
          topCategories: [],
          allTransactions: AllTransaction(today: [], yesterday: []),
          total: {},
        ),
      );

  // -------------------- General --------------------
  @observable
  late Finance finance = _defaultFinance;

  // -------------------- Dollar Account --------------------
  @computed
  FinanceItem get dollarAccount => finance.data.items.firstWhere(
        (element) => element.currency.code == 'USD',
        orElse: () {
          return FinanceItem(currency: Currency());
        },
      );

  // Keep track of previous bar chart data
  @observable
  ObservableMap<String, IncomeExpenseCompare> previousBarData = ObservableMap();

  // **************************************************************************
  // Filtering Variables
  // **************************************************************************
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
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '?$parameter';
  }

  // Query parameter for income
  @computed
  String get queryParemeterIncome {
    String isIncome = FinanceFilterConstant.incomeQuery;
    String period = 'period=${this.period}';
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '?$parameter';
  }

  // Query parameter for expense
  @computed
  String get queryParemeterExpense {
    String isIncome = FinanceFilterConstant.expenseQuery;
    String period = 'period=${this.period}';
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '?$parameter';
  }

  // **************************************************************************
  // Filtered Finance
  // **************************************************************************
  // Map from a query paremeter to the Finance
  @observable
  ObservableMap<String, Finance> filteredFinanceMap = ObservableMap();

  // -------------------- Map Item Initialization --------------------
  @action
  void initialize(String key) {
    if (filteredFinanceMap[key] == null) {
      filteredFinanceMap[key] = _defaultFinance;
    }
  }

  // -------------------- General Filtered Finance --------------------
  @computed
  Finance get filteredFinance => filteredFinanceMap[queryParemeter] == null
      ? _defaultFinance
      : filteredFinanceMap[queryParemeter]!;

  // -------------------- General Expense Finance --------------------
  @computed
  Finance get financeExpense =>
      filteredFinanceMap['?${FinanceFilterConstant.expenseQuery}'] ??
      _defaultFinance;

  // -------------------- Filtered income finance --------------------
  @computed
  Finance get filteredFinanceIncome =>
      filteredFinanceMap[queryParemeterIncome] == null
          ? _defaultFinance
          : filteredFinanceMap[queryParemeterIncome]!;

  // -------------------- Filtered expense finance --------------------
  @computed
  Finance get filteredFinanceExpense =>
      filteredFinanceMap[queryParemeterExpense] == null
          ? _defaultFinance
          : filteredFinanceMap[queryParemeterExpense]!;

  // **************************************************************************
  // Filtered Finance on Specific UI
  // **************************************************************************
  // -------------------- Total Spending --------------------
  @observable
  String totalSpendPeriod = FinanceFilterConstant.thisMonth;

  @computed
  String get totalSpendQuery =>
      '${FinanceFilterConstant.expenseQuery}&period=$totalSpendPeriod';

  @computed
  Finance get totalSpendFinance =>
      filteredFinanceMap['?$totalSpendQuery'] ?? _defaultFinance;

  // -------------------- Total Earning --------------------
  @observable
  String totalEarnPeriod = FinanceFilterConstant.thisMonth;

  @computed
  String get totalEarnQuery =>
      '${FinanceFilterConstant.incomeQuery}&period=$totalEarnPeriod';

  @computed
  Finance get totalEarnFinance =>
      filteredFinanceMap['?$totalEarnQuery'] ?? _defaultFinance;

  // -------------------- Set Loading Status --------------------
  void setLoadingDone() {
    loadingStatus = LoadingStatusEnum.done;
    loadingBarChart = LoadingStatusEnum.done;
    loadingPieChart = LoadingStatusEnum.done;
  }

  void setLoadingError() {
    loadingStatus = LoadingStatusEnum.error;
    loadingBarChart = LoadingStatusEnum.error;
    loadingPieChart = LoadingStatusEnum.error;
  }

  // -------------------- Has Loaded --------------------
  @observable
  bool _hasReadOnce = false;

  // **************************************************************************
  // Read Finance
  // **************************************************************************
  @action
  Future read({
    bool? isIncome,
    VoidCallback? setLoading,
    bool updateFinance = false,
    String? queryParemeter,
  }) async {
    debugPrint('--> START: read finance');

    // check if it's required to set loading
    if (setLoading != null) {
      setLoading();
    }

    // check if required to load income, or expense from other screen
    if (isIncome != null) {
      this.isIncome = isIncome ? 1 : 0;
    }

    queryParemeter ??= this.queryParemeter;

    try {
      Response response =
          await ApiService.dio.get('myfinances/view-my-finance$queryParemeter');

      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        Finance finance = await compute(
          getFinanceModel,
          response.data as Map<String, dynamic>,
        );

        // update general finance
        if (updateFinance) {
          this.finance = finance;
        }

        // store the read finance in a map of {'key': Finance}
        filteredFinanceMap[queryParemeter] = finance;
        setLoadingDone();
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        setLoadingError();
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      setLoadingError();
    } finally {
      debugPrint('<-- END: read finance');
    }
  }

  // **************************************************************************
  // Create Finance
  // **************************************************************************
  @action
  Future<bool> post(FinancePost data) async {
    debugPrint('--> START: post, finance');
    loadingStatus = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'myfinances',
        data: data.toJson(),
      );

      if (response.statusCode == 200) {
        success = true;
        await read();
        loadingStatus = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        loadingStatus = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: post, finance');
    }
    return success;
  }

  // **************************************************************************
  // Update Finance Balance
  // **************************************************************************
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

  // **************************************************************************
  // Dispose
  // **************************************************************************
  void dispose() {
    // reinitialize fields
    loadingStatus = LoadingStatusEnum.none;
    loadingBarChart = LoadingStatusEnum.none;
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
    _hasReadOnce = false;
  }
}
