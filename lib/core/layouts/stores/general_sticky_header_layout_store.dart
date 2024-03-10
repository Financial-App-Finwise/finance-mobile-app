import 'package:mobx/mobx.dart';

part 'general_sticky_header_layout_store.g.dart';

class GeneralStickyHeaderLayoutStore = _GeneralStickyHeaderLayoutStoreBase with _$GeneralStickyHeaderLayoutStore;

abstract class _GeneralStickyHeaderLayoutStoreBase with Store {
  @observable
  double centerContainerHeight = 0;

  @observable
  double headerContainerHeight = 0;

  @observable
  double expandedHeight = 0;

  @observable
  double titleHeight = 0;

  @observable
  double depth = 32;

  @observable
  bool isAppBarExpanded = true;
}