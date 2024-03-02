import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:mobx/mobx.dart';

part 'duration_drop_down_store.g.dart';

class DurationDropDownStore = _DurationDropDownStoreBase
    with _$DurationDropDownStore;

abstract class _DurationDropDownStoreBase with Store {
  @observable
  ObservableList<DurationDropDownItem> items = ObservableList();

  @observable
  String selectedValue = '';

  @action
  void setValue(String value) => selectedValue = value;
}
