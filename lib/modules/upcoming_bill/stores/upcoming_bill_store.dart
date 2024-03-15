import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/upcoming_bill_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/upcoming_bill/helpers/upcoming_bill_helper.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_yearly_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'upcoming_bill_store.g.dart';

class UpcomingBillStore = _UpcomingBillStoreBase with _$UpcomingBillStore;

abstract class _UpcomingBillStoreBase with Store {
  @observable
  UpcomingBillMeta upcomingBillMeta = UpcomingBillMeta();

  @observable
  UpcomingBill upcomingBill = UpcomingBill(
    data: ObservableList(),
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
  void addSelectedDateYear({bool addYear = true}) {
    if (addYear) {
      startDate = DateTime(startDate.year + 1, startDate.month, startDate.day);
    } else {
      startDate = DateTime(startDate.year - 1, startDate.month, startDate.day);
    }
  }

  @action
  void setStartDate(DateTime date) {
    startDate = date;
  }

  @observable
  UpcomingBillFilterEnum filter = UpcomingBillFilterEnum.all;

  @action
  void setFilter(UpcomingBillFilterEnum type) => filter = type;

  @action
  void setNextPage() {
    if (upcomingBill.meta.perPage * upcomingBill.meta.currentPage <=
        upcomingBill.meta.total) {
      upcomingBill.meta.currentPage += 1;
    }
  }

  @computed
  String get queryParameter {
    String filterParameter = UpcomingBillHelper.enumToQuery[filter] ?? '';
    String parameter =
        'date[gte]=${startDate.year}-${startDate.month}-${startDate.day}&date[lte]=${endDate.year}-${endDate.month}-${endDate.day}';

    if (filterParameter.isNotEmpty) {
      return filterParameter;
    }

    return parameter;
  }

  @observable
  ObservableMap<String, UpcomingBillMonth> upcomingBillYearly = ObservableMap();

  @action
  Future readYearly() async {
    debugPrint('--> START: read upcomingbill yearly');
    status = LoadingStatusEnum.loading;
    try {
      Response response =
          await ApiService.dio.get('upcomingbills?year=${startDate.year}');
      if (response.statusCode == 200) {
        upcomingBillYearly = ObservableMap.of(await compute(
            getUpcomingBillYearly, response.data as Map<String, dynamic>));
        status = LoadingStatusEnum.done;
      } else {
        debugPrint('--> Something went wrong, code: ${response.statusCode}');
        status = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      status = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: read upcomingbill yearly');
    }
  }

  @action
  Future read({bool refreshed = false}) async {
    debugPrint('--> Start fetching upcoming bill');

    if (refreshed) {
      status = LoadingStatusEnum.loading;
      upcomingBill.data.clear();
      upcomingBill.meta = UpcomingBillMeta();
      upcomingBill.meta.currentPage = 1;
    }

    try {
      int page = upcomingBill.meta.currentPage;
      String url = 'upcomingbills?$queryParameter&page=$page';
      debugPrint('llll $url');

      Response response = await ApiService.dio.get(url);
      if (response.statusCode == 200) {
        UpcomingBill newUpcomingBill = await compute(
            getUpcomingBill, response.data as Map<String, dynamic>);
        if (upcomingBill.data.length < newUpcomingBill.meta.total &&
            upcomingBill.data.length + newUpcomingBill.data.length <=
                newUpcomingBill.meta.total) {
          upcomingBill.data.addAll(newUpcomingBill.data);
          upcomingBill.meta = newUpcomingBill.meta;
          upcomingBillMeta = newUpcomingBill.meta;
        }
        setNextPage();
        status = LoadingStatusEnum.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching upcoming bill');
    }
  }

  @observable
  LoadingStatusEnum createStatus = LoadingStatusEnum.none;

  @action
  Future<bool> post(UpcomingBillData upcomingBillData) async {
    debugPrint('-->START: post, upcoming bill');
    createStatus = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Map<String, dynamic> jsonData = upcomingBillData.toJson();
      debugPrint('llll $jsonData');
      Response response =
          await ApiService.dio.post('upcomingbills', data: jsonData);
      if (response.statusCode == 201) {
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
      debugPrint('$success');
      debugPrint('<-- End: posting upcoming bill');
    }

    return success;
  }

  @observable
  LoadingStatusEnum editStatus = LoadingStatusEnum.none;

  @action
  Future<bool> edit(UpcomingBillData upcomingBillData) async {
    debugPrint('-->START: edit, upcoming bill');
    editStatus = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Map<String, dynamic> jsonData = upcomingBillData.toJson();
      Response response = await ApiService.dio.put(
        'upcomingbills/${upcomingBillData.id}',
        data: jsonData,
      );
      if (response.statusCode == 200) {
        success = true;
        editStatus = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        editStatus = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      editStatus = LoadingStatusEnum.error;
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
