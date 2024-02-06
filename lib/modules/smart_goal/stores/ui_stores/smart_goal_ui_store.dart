// ----- create a reactive state instead of using setState
import 'package:mobx/mobx.dart';

part 'smart_goal_ui_store.g.dart';

class SmartGoalUIStore = _SmartGoalUIStoreBase with  _$SmartGoalUIStore;

abstract class _SmartGoalUIStoreBase with Store {
  @observable
  bool showGrid = false;

  @action
  void toggleShowGrid() => showGrid = !showGrid;
}