import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/transaction/helpers/transaction_helper.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/models/transaction_post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStoreBase with _$TransactionStore;

abstract class _TransactionStoreBase with Store {
  // -------------------- Loading --------------------
  // General
  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  @computed
  bool get isLoading => loadingStatus == LoadingStatusEnum.loading;

  // Create Transaction
  @observable
  LoadingStatusEnum loadingCreate = LoadingStatusEnum.none;

  @computed
  bool get isLoadingCreate => loadingStatus == LoadingStatusEnum.loading;

  // Update Transaction
  @observable
  LoadingStatusEnum loadingUpdate = LoadingStatusEnum.none;

  @computed
  bool get isLoadingUpdate => loadingUpdate == LoadingStatusEnum.loading;

  // Delete Transaction
  @observable
  LoadingStatusEnum loadingDelete = LoadingStatusEnum.none;

  @computed
  bool get isLoadingDelete => loadingDelete == LoadingStatusEnum.loading;

  // Set Loading Status of General Loading
  @action
  void setLoadingStatus(LoadingStatusEnum status) => loadingStatus = status;

  // -------------------- Transaction --------------------
  // Default
  Transaction get _defaultTransaction =>
      Transaction(items: [], meta: TransactionMeta());

  // General
  @observable
  late Transaction transaction = _defaultTransaction;

  // -------------------- Filter --------------------
  @observable
  int isIncome = 1;

  @observable
  String period = '';

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
  // Base query parameter filter
  @computed
  String get queryParemeter {
    String isIncome = TransactionHelper.typeMap[filteredType]!;
    String period = TransactionHelper.periodMap[filteredPeriod]!;
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '$parameter';
  }

  // Query parameter for income
  @computed
  String get queryParemeterIncome {
    String isIncome = 'isIncome=1';
    String period = '';
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '$parameter';
  }

  // Query parameter for expense
  @computed
  String get queryParemeterExpense {
    String isIncome = 'isIncome=0';
    String period = '';
    String parameter = '$isIncome&$period';
    return '$isIncome$period'.isEmpty ? '' : '$parameter';
  }

  // -------------------- Filtered Transaction --------------------
  // Map from a query paremeter to the Transaction
  @observable
  ObservableMap<String, Transaction> filteredTransactionMap = ObservableMap();

  // -------------------- Initialize Map Item to Avoid Null --------------------
  @action
  void initialize() {
    if (filteredTransactionMap[queryParemeter] == null) {
      filteredTransactionMap[queryParemeter] = _defaultTransaction;
    }
  }

  // Filtered Transaction
  @computed
  Transaction get filteredTransaction =>
      filteredTransactionMap[queryParemeter] == null
          ? _defaultTransaction
          : filteredTransactionMap[queryParemeter]!;

  // Filtered income
  @computed
  Transaction get incomeTransaction =>
      filteredTransactionMap[queryParemeterIncome] == null
          ? _defaultTransaction
          : filteredTransactionMap[queryParemeterIncome]!;

  // Filtered expense
  @computed
  Transaction get expenseTransaction =>
      filteredTransactionMap[queryParemeterExpense] == null
          ? _defaultTransaction
          : filteredTransactionMap[queryParemeterExpense]!;

  // -------------------- Pagination with Filter --------------------
  @action
  Future readByPage({
    bool refreshed = false,
    VoidCallback? setLoading,
    bool updateScreen = false,
  }) async {
    debugPrint('--> START: read transaction');

    // check if it's required to set loading
    if (setLoading != null) {
      setLoading();
    }

    // initialize value of map item
    initialize();

    // if the page is refreshed, reinitialized
    if (refreshed) {
      filteredTransactionMap[queryParemeter]!.items = ObservableList();
      filteredTransactionMap[queryParemeter]!.currentPage = 0;
      setLoadingStatus(LoadingStatusEnum.loading);
    }

    try {
      int page = filteredTransactionMap[queryParemeter]!.currentPage + 1;
      Response response =
          await ApiService.dio.get('transactions?${queryParemeter}&page=$page');
      if (response.statusCode == 200) {
        debugPrint('--> successfully fetched');

        transaction = await compute(
          getTransactionModel,
          response.data as Map<String, dynamic>,
        );

        if (filteredTransactionMap[queryParemeter]!.items.length <
            transaction.meta.total) {
          // add items to the list
          filteredTransactionMap[queryParemeter]!
              .items
              .addAll(transaction.items);

          // increase the page number
          filteredTransactionMap[queryParemeter]!.currentPage++;
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

  // -------------------- Create a Transaction --------------------
  @action
  Future<bool> post(TransactionPost transactionPost) async {
    debugPrint('--> START: post, transaction');
    loadingCreate = LoadingStatusEnum.loading;
    print(transactionPost.toJson());
    bool success = false;
    try {
      Response response = await ApiService.dio.post(
        'transactions',
        data: transactionPost.toJson(),
      );

      if (response.statusCode == 201) {
        success = true;
        await readByPage(refreshed: true);
        loadingCreate = LoadingStatusEnum.done;
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
      debugPrint('<-- END: post, transaction');
    }
    return success;
  }

  // -------------------- Update a Transaction --------------------
  @action
  Future<bool> update(TransactionPost transactionPost, int id) async {
    debugPrint('--> START: update, transaction');
    loadingUpdate = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Response response = await ApiService.dio.patch(
        'transactions/$id',
        data: transactionPost.toJson(),
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
      debugPrint('<-- END: update, transaction');
    }
    return success;
  }

  // -------------------- Delete a Transaction --------------------
  @action
  Future<bool> delete(TransactionData transactionData) async {
    debugPrint('--> START: delete, transaction');
    loadingDelete = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Response response =
          await ApiService.dio.delete('transactions/${transactionData.id}');
      if (response.statusCode == 200) {
        success = true;
        await readByPage(refreshed: true);
        loadingDelete = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        loadingDelete = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingDelete = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: delete, transaction');
    }
    return success;
  }

  void dispose() {
    setLoadingStatus(LoadingStatusEnum.none);
    changeFilteredType(TransactionTypeEnum.all);
    changeFilteredPeriod(TransactionPeriodEnum.all);
    filteredTransactionMap = ObservableMap();
  }
}
