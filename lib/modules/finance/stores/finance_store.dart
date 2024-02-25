import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/finance/models/finance_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'finance_store.g.dart';

class FinanceStore = _FinanceStoreBase with _$FinanceStore;

abstract class _FinanceStoreBase with Store {
  // ---------- Loading ----------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // ---------- Finance ----------
  @observable
  Finance finance = Finance(
    data: FinanceData(
      items: [],
      topTransaction: [],
      allTransaction: AllTransaction(today: [], yesterday: []),
      total: Total(
        week1: Week(),
        week2: Week(),
        week3: Week(),
        week4: Week(),
      ),
    ),
  );

  @computed
  FinanceItem get dollarAccount => finance.data.items.firstWhere(
        (element) => element.currency.code == 'USD',
        orElse: () {
          return FinanceItem(currency: Currency());
        },
      );

  // ---------- read finance ----------
  @action
  Future read() async {
    debugPrint('--> START: read finance');
    loadingStatus = LoadingStatusEnum.loading;
    try {
      Response response = await ApiService.dio
          .get('myfinances/view-my-finance?period=this_month');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');
        finance = await compute(
          getFinanceModel,
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
      debugPrint('<-- END: read finance');
    }
  }

  //myfinances/update-net-worth
  // -------------------- Update a Smart Goal --------------------
  @action
  Future<bool> update(double totalbalance) async {
    debugPrint('--> START: update, finance');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response = await ApiService.dio.put(
        'myfinances/update-net-worth',
        data: {'totalbalance': totalbalance},
      );
      if (response.statusCode == 200) {
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
      debugPrint('<-- END: update, finance');
    }
    return success;
  }
}
