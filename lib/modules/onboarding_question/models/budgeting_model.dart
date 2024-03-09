import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:mobx/mobx.dart';

class BudgetingModel {
  double housing;
  double food;
  double utilities;
  SpendingModel spending;

  BudgetingModel({
    @observable this.housing = 0,
    this.food = 0,
    this.utilities = 0,
    SpendingModel? spending,
  }) : spending = spending ?? SpendingModel();

  // BudgetingModel({
  //   this.housing = 0,
  //   this.food = 0,
  //   this.utilities = 0,
  //   SpendingModel? spending,
  // }) : spending = spending ??
  //           SpendingModel(
  //             type: 'Daily',
  //             controller: TextEditingController(),
  //           );
}
