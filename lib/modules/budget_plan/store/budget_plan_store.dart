import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/enums/budget_plan_enum.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/budget_plan/helpers/budget_plan_helper.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_yearly_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'budget_plan_store.g.dart';

class BudgetPlanStore = _BudgetPlanStoreBase with _$BudgetPlanStore;

abstract class _BudgetPlanStoreBase with Store {
  @observable
  BudgetPlan budgetPlan = BudgetPlan(data: BudgetPlanItem(budgetPlans: []));

  @observable
  BudgetPlanYearly budgetPlanYearly = BudgetPlanYearly(data: BudgetPlanMonth());

  @observable
  LoadingStatusEnum status = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => status = status;

  @observable
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  @action
  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }

  @action
  void addSelectedDateYear({bool addYear = true}) {
    if (addYear) {
      selectedDate =
          DateTime(selectedDate.year + 1, selectedDate.month, selectedDate.day);
    } else {
      selectedDate =
          DateTime(selectedDate.year - 1, selectedDate.month, selectedDate.day);
    }
  }

  @observable
  BudgetPlanFilterEnum filter = BudgetPlanFilterEnum.all;

  @action
  void setFilter(BudgetPlanFilterEnum type) => filter = type;

  @computed
  String get queryParameter {
    String filterParameter = BudgetPlanHelper.enumToQuery[filter] ?? '';
    String parameter = '/${selectedDate.year}/${selectedDate.month}';

    if (filterParameter.isNotEmpty) {
      parameter += '?$filterParameter';
    }

    return parameter;
  }

  @action
  Future readYearly() async {
    debugPrint('--> START: read budgetplan yearly');
    status = LoadingStatusEnum.loading;
    try {
      Response response =
          await ApiService.dio.get('budgetplans/summary/${selectedDate.year}');
      if (response.statusCode == 200) {
        budgetPlanYearly = await compute(
            getBudgetPlanYearly, response.data as Map<String, dynamic>);
        status = LoadingStatusEnum.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching budget plan');
    }
  }

  @action
  Future read({bool refreshed = false}) async {
    debugPrint('--> Start fetching budget plan');

    if (refreshed) {
      status = LoadingStatusEnum.loading;
      budgetPlan = BudgetPlan(data: BudgetPlanItem(budgetPlans: []));
    }

    try {
      String url = 'budgetplans$queryParameter';
      debugPrint('llll $url');
      Response response = await ApiService.dio.get(url);
      if (response.statusCode == 200) {
        budgetPlan =
            await compute(getBudgetPlan, response.data as Map<String, dynamic>);
        status = LoadingStatusEnum.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching budget plan');
    }
  }

  @observable
  LoadingStatusEnum createStatus = LoadingStatusEnum.none;

  @action
  Future<bool> post(BudgetPlanData budgetPlanData) async {
    debugPrint('--> START: post, budget plan');
    createStatus = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Map<String, dynamic> jsonData = budgetPlanData.toJson();
      Response response =
          await ApiService.dio.post('budgetplans', data: jsonData);
      if (response.statusCode == 200) {
        success = true;
        createStatus = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        createStatus = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      createStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- End: posting budget plan');
    }

    return success;
  }

  @action
  Future<bool> edit(BudgetPlanData budgetPlanData) async {
    debugPrint('--> START: edit, budget plan');
    bool success = false;
    try {
      Map<String, dynamic> jsonData = budgetPlanData.toJson();
      Response response = await ApiService.dio
          .put('budgetplans/${budgetPlanData.id}', data: jsonData);
      if (response.statusCode == 200) {
        success = true;
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
      debugPrint('<-- END: edit, budget plan');
    }
    return success;
  }

  @action
  Future<bool> delete(BudgetPlanData budgetPlanData) async {
    debugPrint('--> START: delete, budget plan');
    setLoadingStatus(LoadingStatusEnum.loading);
    bool success = false;
    try {
      Response response =
          await ApiService.dio.delete('budgetplans/${budgetPlanData.id}');
      if (response.statusCode == 200) {
        success = true;
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
      debugPrint('<-- END: delete, budget plan');
    }
    return success;
  }
}
