import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'budget_plan_store.g.dart';

class BudgetPlanStore = _BudgetPlanStoreBase with _$BudgetPlanStore;

abstract class _BudgetPlanStoreBase with Store {
  @observable
  BudgetPlan budgetPlan = BudgetPlan(data: []);

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future read() async {
    debugPrint('--> Start fetching budget plan');
    status = LoadingStatus.loading;

    try {
      Response response = await ApiService.dio.get('budgetplans');
      debugPrint('llll ${response.data['data']}');
      if (response.statusCode == 200) {
        // budgetPlan =
        //     await compute(getBudgetPlan, response.data as Map<String, dynamic>);
        status = LoadingStatus.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching budget plan');
    }
  }
}
