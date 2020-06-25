import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/common/helpers/workout_helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_hub/model/enums/workout_level_type.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_hub/model/params/workout_params.dart';
import 'package:workout_hub/model/workout_model.dart';
import 'package:workout_hub/providers/workouts_provider.dart';
import 'package:workout_hub/widgets/workout_page/workout_reorderable_card.dart';

class WorkoutListPage extends StatefulWidget {
  final WorkoutListParams params;
  WorkoutListPage(this.params);
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  List<WorkoutConfigModel> workouts;// = List<WorkoutConfigModel>();
  @override
  void initState(){
    super.initState();
    var workoutsProvider = Provider.of<WorkoutsProvider>(context, listen: false);    
    if(widget.params.level == WorkoutLevelType.beginner){
      workouts =  workoutsProvider.levelsModel.level1.firstWhere((element) => element.level == widget.params.level && element.type == widget.params.type)?.data;
    }else if(widget.params.level == WorkoutLevelType.intermediate){
      workouts =  workoutsProvider.levelsModel.level2.firstWhere((element) => element.level == widget.params.level && element.type == widget.params.type)?.data;
    }else{
      workouts =  workoutsProvider.levelsModel.level3.firstWhere((element) => element.level == widget.params.level && element.type == widget.params.type)?.data;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(getLevelTitle(widget.params).toUpperCase()),
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "${widget.params.type}_${widget.params.level}",
                  child: Container(                  
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(getAppBarBackgroundImage(widget.params)), fit: BoxFit.cover,)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(getLevelImage(widget.params), height: 32,),
                        )
                      ],
                    ),                  
                  ),
                ),
                //padding: EdgeInsets.only(bottom: 100),
              ),
              expandedHeight: 200,
            ),
            ReorderableSliverList(
              delegate: buildReorderableSliverChild(),
              onReorder: reorderList,
            ),            
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton.icon(
          onPressed: _onStart,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          icon: Icon(Icons.playlist_play),
          label: Text('buttons.start'.tr().toUpperCase(), style: Theme.of(context).textTheme.headline5,),
        ),
      ),
    );
  }

  SliverChildDelegate buildReorderableSliverChild(){    
    return ReorderableSliverChildBuilderDelegate(
      (BuildContext context, int index) => WorkoutReorderableCard(workouts, index, Key('$index')),
      childCount: workouts.length
    );
  }
  
  void reorderList(oldIndex, newIndex){  
    setState(() {
      var temp = workouts[oldIndex];
       workouts.removeAt(oldIndex);
       workouts.insert(newIndex, temp);
    });    
  }
  
  void _onStart(){
    Navigator.pushNamed(context, Constants.ROOUTE_NAME_TO_WORKOUT_PAGE, arguments: WorkoutParams(workouts.where((element) => element.disable != true ).toList()));
  }
}