import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/upcoming_bill_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/upcoming_bill/helpers/upcoming_bill_helper.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'upcoming_bill_store.g.dart';

class UpcomingBillStore = _UpcomingBillStoreBase with _$UpcomingBillStore;

abstract class _UpcomingBillStoreBase with Store {
  @observable
  UpcomingBill upcomingBill = UpcomingBill(
    data: [],
    meta: UpcomingBillMeta(),
  );

  @observable
  LoadingStatusEnum status = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => status = status;

  @observable
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @computed
  DateTime get endDate {
    DateTime date = DateTime(startDate.year, startDate.month + 1, 1);
    return date;
  }

  @action
  void setStartDate(DateTime date) {
    startDate = date;
  }

  @observable
  UpcomingBillFilterEnum filter = UpcomingBillFilterEnum.all;

  @action
  void setFilter(UpcomingBillFilterEnum type) => filter = type;

  @observable
  int page = 1;

  @action
  void setNextPage() {
    if (upcomingBill.meta.perPage * page <= upcomingBill.meta.total) {
      page++;
    }
  }

  @observable
  ObservableMap<String, UpcomingBill> filteredUpcomingBill = ObservableMap();

  @computed
  String get queryParameter {
    String filterParameter = UpcomingBillHelper.enumToQuery[filter] ?? '';
    String parameter =
        '?date[gte]=${startDate.year}-${startDate.month}-${startDate.day}&date[lte]=${endDate.year}-${endDate.month}-${endDate.day}';

    if (filterParameter.isNotEmpty) {
      return '?$filterParameter&page=$page';
    }

    return '$parameter&page=$page';
  }

  @action
  void initialize() {
    if(filteredUpcomingBill[queryParameter] == null) {
      filteredUpcomingBill[queryParameter] = UpcomingBill(data: ObservableList.of([]), meta: UpcomingBillMeta());
    }
  }

  @action
  Future read({bool refreshed = false}) async {
    debugPrint('--> Start fetching upcoming bill');

    initialize();

    if (refreshed) {
      status = LoadingStatusEnum.loading;
      filteredUpcomingBill[queryParameter]!.data = ObservableList();
      filteredUpcomingBill[queryParameter]!.meta = UpcomingBillMeta();
      filteredUpcomingBill[queryParameter]!.meta.currentPage = 1;
      page = 1;
    }

    try {
      String url = 'upcomingbills$queryParameter';
      debugPrint('llll $url');

      Response response = await ApiService.dio.get(url);
      if (response.statusCode == 200) {
        upcomingBill = await compute(
            getUpcomingBill, response.data as Map<String, dynamic>);
        setNextPage();
        status = LoadingStatusEnum.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching upcoming bill');
    }
  }

  @action
  Future<bool> post(UpcomingBillData upcomingBillData) async {
    debugPrint('-->START: post, upcoming bill');
    bool success = false;
    try {
      Map<String, dynamic> jsonData = upcomingBillData.toJson();
      debugPrint('llll $jsonData');
      Response response =
          await ApiService.dio.post('upcomingbills', data: jsonData);
      if (response.statusCode == 201) {
        success = true;
        setLoadingStatus(LoadingStatusEnum.done);
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        setLoadingStatus(LoadingStatusEnum.error);
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('$success');
      debugPrint('<-- End: posting upcoming bill');
    }

    return success;
  }

  @action
  Future<bool> edit(UpcomingBillData upcomingBillData) async {
    debugPrint('-->START: edit, upcoming bill');
    bool success = false;
    try {
      Map<String, dynamic> jsonData = upcomingBillData.toJson();
      Response response = await ApiService.dio.put(
        'upcomingbills/${upcomingBillData.id}',
        data: jsonData,
      );
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
      debugPrint('<-- END: edit, upcoming bill');
    }
    return success;
  }

  @action
  Future<bool> delete(UpcomingBillData upcomingBillData) async {
    debugPrint('-->START: delete, upcoming bill');
    bool success = false;
    try {
      Response response =
          await ApiService.dio.delete('upcomingbills/${upcomingBillData.id}');
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
      debugPrint('<-- END: delete, upcoming bill');
    }
    return success;
  }
}
