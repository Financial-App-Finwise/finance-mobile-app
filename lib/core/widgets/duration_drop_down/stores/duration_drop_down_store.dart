import 'package:mobx/mobx.dart';

part 'duration_drop_down_store.g.dart';

class DurationDropDownStore = _DurationDropDownStoreBase
    with _$DurationDropDownStore;

abstract class _DurationDropDownStoreBase with Store {
  @observable
  List<Map<String, String>> items = [
    {
      'label': 'This Month',
      'value': 'this_month',
    },
    {
      'label': 'This Week',
      'value': 'this_week',
    },
  ];

  @observable
  String selectedValue = 'this_month';

  @action
  void setValue(String value) => selectedValue = value;
}
