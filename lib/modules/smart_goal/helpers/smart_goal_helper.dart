import 'package:finwise/core/enums/smart_goal_status_enum.dart';

abstract class SmartGoalHelper {
  static Map<SmartGoalStatusEnum, String> enumToQuery = {
    SmartGoalStatusEnum.all: '',
    SmartGoalStatusEnum.inProgress: 'remainingSave[gt]=0',
    SmartGoalStatusEnum.achieved: 'remainingSave[eq]=0',
  };
}