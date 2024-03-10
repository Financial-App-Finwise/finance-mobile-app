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
      topTransactions: [],
      allTransactions: AllTransaction(today: [], yesterday: []),
      total: [],
    ),
  );

  @computed
  FinanceItem get dollarAccount => finance.data.items.firstWhere(
        (element) => element.currency.code == 'USD',
        orElse: () {
          return FinanceItem(currency: Currency());
        },
      );

  // ---------- Period Filter ----------
  @observable
  String period = 'this_month';

  @observable
  int isIncome = 0;

  @observable
  Finance incomeFinance = Finance(
    data: FinanceData(
      items: [],
      topTransactions: [],
      allTransactions: AllTransaction(today: [], yesterday: []),
      total: [],
    ),
  );

  @observable
  Finance expenseFinance = Finance(
    data: FinanceData(
      items: [],
      topTransactions: [],
      allTransactions: AllTransaction(today: [], yesterday: []),
      total: [],
    ),
  );

  // -------------------- read finance --------------------
  @action
  Future read() async {
    debugPrint('--> START: read finance');
    loadingStatus = LoadingStatusEnum.loading;
    barChartLoading = LoadingStatusEnum.loading;
    try {
      // get expense
      Response response = await ApiService.dio
          .get('myfinances/view-my-finance?isIncome=1&period=$period');

      // get income
      Response response2 = await ApiService.dio
          .get('myfinances/view-my-finance?isIncome=0&period=$period');

      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        finance = await compute(
          getFinanceModel,
          response.data as Map<String, dynamic>,
        );

        incomeFinance = await compute(
          getFinanceModel,
          response.data as Map<String, dynamic>,
        );

        expenseFinance = await compute(
          getFinanceModel,
          response2.data as Map<String, dynamic>,
        );

        // print('fetched and converted: ${finance.data.total}');
        if (finance.data.total.runtimeType.toString() ==
            "_Map<String, dynamic>") {
          // Map<String, dynamic> map = {};
          // map.forEach((key, value) {});
          // finance.data.total.forEach((key, value) {
          //   print('$key: $value');
          // });
        }
        loadingStatus = LoadingStatusEnum.done;
        barChartLoading = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        loadingStatus = LoadingStatusEnum.error;
        barChartLoading = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      loadingStatus = LoadingStatusEnum.error;
      barChartLoading = LoadingStatusEnum.error;
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
  LoadingStatusEnum updateLoading = LoadingStatusEnum.none;

  @action
  Future<bool> update(double totalbalance) async {
    debugPrint('--> START: update, finance');
    updateLoading = LoadingStatusEnum.loading;

    bool success = false;
    try {
      Response response = await ApiService.dio.put(
        'myfinances/update-net-worth',
        data: {'totalbalance': totalbalance},
      );
      if (response.statusCode == 200) {
        success = true;
        updateLoading = LoadingStatusEnum.done;
        await read();
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        updateLoading = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      updateLoading = LoadingStatusEnum.error;
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
        topTransactions: [],
        allTransactions: AllTransaction(today: [], yesterday: []),
        total: [],
      ),
    );
    period = 'this_month';
    isIncome = 0;
    incomeFinance = Finance(
      data: FinanceData(
        items: [],
        topTransactions: [],
        allTransactions: AllTransaction(today: [], yesterday: []),
        total: [],
      ),
    );
    expenseFinance = Finance(
      data: FinanceData(
        items: [],
        topTransactions: [],
        allTransactions: AllTransaction(today: [], yesterday: []),
        total: [],
      ),
    );
  }
}
