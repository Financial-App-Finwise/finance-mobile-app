import 'package:mobx/mobx.dart';

part 'general_filter_bar_header_store.g.dart';

class FilterBarHeaderStore = _FilterBarHeaderStoreBase with _$FilterBarHeaderStore;

abstract class _FilterBarHeaderStoreBase with Store {
  @observable
  var currentValue;

  @action
  void changeCurrentValue(var value) => currentValue = value;
}