import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:workout_hub/common/error_messages.dart';
import 'package:workout_hub/common/helpers/workout_helpers.dart';
import 'package:workout_hub/model/enums/workout_level_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_hub/model/enums/workout_type.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_hub/widgets/workout_page/workout_reorderable_card.dart';

class WorkoutListPage extends StatefulWidget {
  final WorkoutListParams params;
  WorkoutListPage(this.params);
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {

List<String> alphabetList = [
    'J',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];

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
              delegate: ReorderableSliverChildBuilderDelegate(
                (BuildContext context, int index) => WorkoutReorderableCard(alphabetList, index, Key('$index')),
                childCount: alphabetList.length
              ),
              onReorder: (oldIndex, newIndex)=>{ }
            ),            
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton.icon(
          onPressed: () {},
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          icon: Icon(Icons.playlist_play),
          label: Text('start'.tr().toUpperCase(), style: Theme.of(context).textTheme.headline5,),
        ),
      ),
    );
  }
  
}