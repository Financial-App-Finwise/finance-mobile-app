import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:mobx/mobx.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStoreBase with _$TransactionStore;

abstract class _TransactionStoreBase with Store {
  // example data
  @observable
  ObservableList<TransactionData> transactions = ObservableList.of([
    TransactionData(isIncome: false),
    TransactionData(isIncome: true),
    TransactionData(isIncome: true),
    TransactionData(isIncome: false),
    TransactionData(isIncome: false),
    TransactionData(isIncome: true),
  ]);

  @observable
  TransactionTypeEnum filteredType = TransactionTypeEnum.all;

  @action
  void changeFilteredType(TransactionTypeEnum type) => filteredType = type;

  @computed
  ObservableList<TransactionData> get incomeTransactions =>
      ObservableList.of(transactions.where((element) => element.isIncome));

  @computed
  ObservableList<TransactionData> get expenseTransactions =>
      ObservableList.of(transactions.where((element) => !element.isIncome));

  @computed
  ObservableList<TransactionData> get typeFilteredTransactions {
    switch (filteredType) {
      case TransactionTypeEnum.income:
        return incomeTransactions;
      case TransactionTypeEnum.expense:
        return expenseTransactions;
      default:
        return transactions;
    }
  }

  @action
  void getTransaction() {}
}
