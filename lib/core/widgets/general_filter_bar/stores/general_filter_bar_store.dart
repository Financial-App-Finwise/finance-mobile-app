import 'package:mobx/mobx.dart';

part 'general_filter_bar_store.g.dart';

class GeneralFilterBarStore = _GeneralFilterBarStoreBase with _$GeneralFilterBarStore;

abstract class _GeneralFilterBarStoreBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void changeIndex(int value) => currentIndex = value;
}