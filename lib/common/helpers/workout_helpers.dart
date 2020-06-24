import 'package:workout_hub/common/error_messages.dart';
import 'package:workout_hub/model/enums/workout_level_type.dart';
import 'package:workout_hub/model/enums/workout_type.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';
import 'package:easy_localization/easy_localization.dart';

String getLevelTitle(WorkoutListParams params){
    if(params.level == WorkoutLevelType.beginner){
      switch(params.type){
        case WorkoutType.abs:
          return 'level_1.abs'.tr();
        case WorkoutType.arm:
          return 'level_1.arm'.tr();
        case WorkoutType.chest:
          return 'level_1.chest'.tr();
        case WorkoutType.leg:
          return 'level_1.leg'.tr();
        case WorkoutType.shoulder:
          return 'level_1.shoulder'.tr();
        default:
          throw(ErrorMessages.WORKOUT_TYPE_IS_NOT_FOUND); 
      } 
    }
    else if(params.level == WorkoutLevelType.intermediate){
      switch(params.type){
        case WorkoutType.abs:
          return 'level_2.abs'.tr();
        case WorkoutType.arm:
          return 'level_2.arm'.tr();
        case WorkoutType.chest:
          return 'level_2.chest'.tr();
        case WorkoutType.leg:
          return 'level_2.leg'.tr();
        case WorkoutType.shoulder:
          return 'level_2.shoulder'.tr();
        default:
          throw(ErrorMessages.WORKOUT_TYPE_IS_NOT_FOUND); 
      } 
    }
    else if(params.level == WorkoutLevelType.advanced){
      switch(params.type){
        case WorkoutType.abs:
          return 'level_3.abs'.tr();
        case WorkoutType.arm:
          return 'level_3.arm'.tr();
        case WorkoutType.chest:
          return 'level_3.chest'.tr();
        case WorkoutType.leg:
          return 'level_3.leg'.tr();
        case WorkoutType.shoulder:
          return 'level_3.shoulder'.tr();
        default:
          throw(ErrorMessages.WORKOUT_TYPE_IS_NOT_FOUND); 
      } 
    }
    throw(ErrorMessages.WORKOUT_LEVEL_IS_NOT_FOUND); 
  }

  String getAppBarBackgroundImage(WorkoutListParams params){
    switch(params.type){
        case WorkoutType.abs:
          return 'assets/bg/cover_abs_${params.level}.jpg';
        case WorkoutType.arm:
          return 'assets/bg/cover_arm_${params.level}.jpg';
        case WorkoutType.chest:
          return 'assets/bg/cover_chest_${params.level}.jpg';
        case WorkoutType.leg:
         return 'assets/bg/cover_leg_${params.level}.jpg';
        case WorkoutType.shoulder:
          return 'assets/bg/cover_shoulder_${params.level}.jpg';
        default:
          throw(ErrorMessages.WORKOUT_TYPE_IS_NOT_FOUND); 
      } 
  }

  String getLevelImage(WorkoutListParams params){
    return 'assets/icons/rate_${params.level}.svg';
  }