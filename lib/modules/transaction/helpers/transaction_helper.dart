import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';

class TransactionHelper {
  static final Map<TransactionTypeEnum, String> typeMap = {
    TransactionTypeEnum.all: '',
    TransactionTypeEnum.income: 'isIncome[eq]=1',
    TransactionTypeEnum.expense: 'isIncome[eq]=0',
  };

  static final Map<TransactionPeriodEnum, String> periodMap = {
    TransactionPeriodEnum.all: '',
    TransactionPeriodEnum.recently: '',
    TransactionPeriodEnum.earliest: '',
    TransactionPeriodEnum.hightest: '',
    TransactionPeriodEnum.lowest: '',
  };
}