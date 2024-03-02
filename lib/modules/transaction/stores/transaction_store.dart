import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/transaction/helpers/transaction_helper.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStoreBase with _$TransactionStore;

abstract class _TransactionStoreBase with Store {
  // -------------------- Loading --------------------
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // -------------------- Transaction --------------------
  @observable
  Transaction transaction = Transaction(items: [], meta: TransactionMeta());

  // -------------------- Filtering Variable --------------------
  @observable
  TransactionTypeEnum filteredType = TransactionTypeEnum.all;

  @observable
  TransactionPeriodEnum filteredPeriod = TransactionPeriodEnum.all;

  @action
  void changeFilteredType(TransactionTypeEnum type) => filteredType = type;

  @action
  void changeFilteredPeriod(TransactionPeriodEnum type) =>
      filteredPeriod = type;

  // -------------------- Query Paremeter --------------------
  // Convert the value of selected filtering button to the query Paremeter
  @computed
  String get queryParemeter {
    String filter1 = TransactionHelper.typeMap[filteredType] ?? '';
    String filter2 = TransactionHelper.periodMap[filteredPeriod] ?? '';

    if ('$filter1$filter2'.isEmpty) {
      return '';
    }
    return '$filter1&$filter2';
  }

  // -------------------- Reaction --------------------
  late ReactionDisposer _disposer;
  void setReaction() {
    // recheck with 'queryParemeter', not with filteredType
    _disposer = reaction((_) => queryParemeter, (value) async {
      bool refreshed = false;
      if (filteredTransaction[queryParemeter] == null) {
        refreshed = true;
      }
      await readByPage(refreshed: refreshed);
    });
  }

  // -------------------- Filtered Transaction --------------------
  // Map from a query paremeter to the Transaction
  @observable
  ObservableMap<String, Transaction> filteredTransaction = ObservableMap();

  @action
  void initialize() {
    if (filteredTransaction[queryParemeter] == null) {
      filteredTransaction[queryParemeter] =
          Transaction(items: ObservableList.of([]), meta: TransactionMeta());
    }
  }

  // -------------------- Pagination and Filter --------------------
  @action
  Future readByPage({bool refreshed = false}) async {
    debugPrint('--> START: read transaction');

    // initialize value of map item
    initialize();

    // if the page is refreshed, reinitialized
    if (refreshed) {
      filteredTransaction[queryParemeter]!.items = ObservableList();
      filteredTransaction[queryParemeter]!.currentPage = 0;
      setLoadingStatus(LoadingStatusEnum.loading);
    }

    // increase the page number
    filteredTransaction[queryParemeter]!.currentPage++;

    try {
      int page = filteredTransaction[queryParemeter]!.currentPage;
      Response response =
          await ApiService.dio.get('transactions/?${queryParemeter}page=$page');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');

        transaction = await compute(
            getTransactionModel, response.data as Map<String, dynamic>);

        if (filteredTransaction[queryParemeter]!.items.length <
            transaction.meta.total) {
          filteredTransaction[queryParemeter]!.items.addAll(transaction.items);
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
      debugPrint('<-- END: read transaction');
    }
  }

//   {
//     "categoryID": 3,
//     "isIncome": 1,
//     "amount": "50.00",
//     "hasContributed": 1,
//     "upcomingbillID": null,
//     "budgetplanID": null,
//     "expenseType": "General",
//     "date": "2023-11-01 12:00:00",
//     "note": "Bought groceries abc"
// }

  // -------------------- Create a Transaction --------------------
  @action
  Future<bool> post(TransactionData transactionData) async {
    debugPrint('--> START: post, transaction');
    setLoadingStatus(LoadingStatusEnum.loading);
    print(transactionData.toJson());
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'transactions',
        data: transactionData.toJson(),
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
      debugPrint('<-- END: post, transaction');
    }
    return success;
  }

  // -------------------- Delete a Smart Goal --------------------
  @action
  Future<bool> delete(TransactionData transactionData) async {
    debugPrint('--> START: delete, transaction');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response =
          await ApiService.dio.delete('transactions/${transactionData.id}');
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
      debugPrint('<-- END: delete, transaction');
    }
    return success;
  }

  void dispose() {
    setLoadingStatus(LoadingStatusEnum.none);
    changeFilteredType(TransactionTypeEnum.all);
    changeFilteredPeriod(TransactionPeriodEnum.all);
    filteredTransaction = ObservableMap();
    _disposer();
  }
}
