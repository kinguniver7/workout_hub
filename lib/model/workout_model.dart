class WorkoutModel{
  int id;
  String title;
  String desc;
  Duration time;
  int repeats;
  String image;
  WorkoutModel({this.id, this.title,this.desc,this.image, this.time});
}

class WorkoutConfigModel{
  String workoutAliase;
  int time;
  int repeats;
  bool disable;

  String get desc => time != null ? "00:$time" : "x${repeats??0}";

  WorkoutConfigModel.fromJson(Map<String, dynamic> json)
    : workoutAliase = json['workoutAliase'],
    time = json['time'],
    repeats = json['repeats'],
    disable = json['disable'];
}
class LevelItemModel{
  String name;
  int type;
  int level;
  List<WorkoutConfigModel> data;

  LevelItemModel.fromJson(Map<String, dynamic> json)
    : name = json['name'],
    type = json['type'],
    level = json['level'],
    data = (json["data"] as List).map((i) => WorkoutConfigModel.fromJson(i)).toList();

}
class LevelsListModel{
  List<LevelItemModel> level1;
  List<LevelItemModel> level2;
  List<LevelItemModel> level3;

  LevelsListModel.fromJson(Map<String, dynamic> json)
    : level1 = (json["level1"] as List).map((i) => LevelItemModel.fromJson(i)).toList(),
    level2 = (json["level2"] as List).map((i) => LevelItemModel.fromJson(i)).toList(),
    level3 = (json["level3"] as List).map((i) => LevelItemModel.fromJson(i)).toList();
}