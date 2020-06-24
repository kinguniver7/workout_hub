import 'package:flutter/material.dart';
import 'package:workout_hub/model/workout_model.dart';

class WorkoutsProvider extends ChangeNotifier{

  LevelsListModel _levelsModel;
  LevelsListModel get levelsModel => _levelsModel;
  set levelsModel(LevelsListModel data){
    _levelsModel = data;
    notifyListeners();
  }

}