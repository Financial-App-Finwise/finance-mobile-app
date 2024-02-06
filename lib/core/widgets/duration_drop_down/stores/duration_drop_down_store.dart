import 'package:mobx/mobx.dart';

part 'duration_drop_down_store.g.dart';

class DurationDropDownStore = _DurationDropDownStoreBase
    with _$DurationDropDownStore;

abstract class _DurationDropDownStoreBase with Store {
  @observable
  List items = [
    'This Month',
    'This Week',
    'Last Week',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
  ];

  @observable
  String selectedValue = 'This Month';

  @action
  void setValue(String value) => selectedValue = value;
}
