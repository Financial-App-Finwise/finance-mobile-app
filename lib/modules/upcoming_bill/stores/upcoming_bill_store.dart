import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'upcoming_bill_store.g.dart';

class UpcomingBillStore = _UpcomingBillStoreBase with _$UpcomingBillStore;

abstract class _UpcomingBillStoreBase with Store {
  @observable
  UpcomingBill upcomingBill = UpcomingBill(data: []);

  @observable
  LoadingStatusEnum status = LoadingStatusEnum.none;

  @action
  void setLoadingStatus(LoadingStatusEnum status) => status = status;

  @action
  Future read() async {
    debugPrint('--> Start fetching upcoming bill');
    status = LoadingStatusEnum.loading;

    try {
      Response response = await ApiService.dio.get('upcomingbills');
      if (response.statusCode == 200) {
        upcomingBill = await compute(
            getUpcomingBill, response.data as Map<String, dynamic>);
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
