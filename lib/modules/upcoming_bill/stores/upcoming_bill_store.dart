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
}
