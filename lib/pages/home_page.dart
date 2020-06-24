import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/model/enums/workout_level_type.dart';
import 'package:workout_hub/model/enums/workout_type.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';
import 'package:workout_hub/model/workout_model.dart';
import 'package:workout_hub/providers/workouts_provider.dart';
import 'package:workout_hub/widgets/home_page/play_panel.dart';
import 'package:workout_hub/widgets/home_page/today_panel.dart';
import 'package:workout_hub/widgets/left_drawer.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: loadJsonData(),
      builder: (BuildContext context, AsyncSnapshot<LevelsListModel> snapshot){
        if(snapshot.hasData == true){
          return Scaffold(
            drawer: LeftDrawer(),
            appBar: AppBar(title: Text('home_page.title').tr(),),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[          
                Expanded(
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        child: Stack(  
                          alignment: Alignment.center,          
                          children: <Widget>[
                            buildClipPath(),
                            Positioned(
                              bottom: 20,
                              child: Container(
                                height: 140.0,
                                width: 140.0,
                                child: Center(child: SvgPicture.asset("assets/coach/man_1.svg", height: 130,)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).primaryColor,
                                        blurRadius: 1.0,
                                        //offset: Offset(2.0, 2.0),
                                        spreadRadius: 1.0)
                                  ],
                                ),
                              ),
                            )              
                          ],
                        ),
                      ),
                      Wrap(
                        //spacing: 20,
                        runSpacing: 12,
                        children: getMainContent(),
                      ),
                    ],
                  )
                ) 
              ],
            ),      
          );
        }
        else{
          return Scaffold(body: Center(child: CircularProgressIndicator()),);
        }
        
    });
    }
  
  List<Widget> getMainContent(){
    var workoutsProvider = Provider.of<WorkoutsProvider>(context, listen: false);

    List<Widget> childrens = new List<Widget>();
    childrens.add(TodayPanel());
    childrens.add(Center(child: Text('level_1.title'.tr(), style: Theme.of(context).textTheme.headline6,)));
    childrens.addAll(workoutsProvider.levelsModel.level1.map<Widget>((e) => 
      InkWell(
        onTap: () => {Navigator.pushNamed(context, Constants.ROOUTE_NAME_TO_WORKOUT_LIST_PAGE, arguments: WorkoutListParams(e.level, e.type))},
        child: PlayPanel(WorkoutListParams(e.level, e.type))
      ),
    ));
    childrens.add(Center(child: Text('level_2.title'.tr(), style: Theme.of(context).textTheme.headline6,)));
    childrens.addAll(workoutsProvider.levelsModel.level2.map<Widget>((e) => 
      InkWell(
        onTap: () => {Navigator.pushNamed(context, Constants.ROOUTE_NAME_TO_WORKOUT_LIST_PAGE, arguments: WorkoutListParams(e.level, e.type))},
        child: PlayPanel(WorkoutListParams(e.level, e.type))
      ),
    ));
    childrens.add(Center(child: Text('level_3.title'.tr(), style: Theme.of(context).textTheme.headline6,)));
    childrens.addAll(workoutsProvider.levelsModel.level3.map<Widget>((e) => 
      InkWell(
        onTap: () => {Navigator.pushNamed(context, Constants.ROOUTE_NAME_TO_WORKOUT_LIST_PAGE, arguments: WorkoutListParams(e.level, e.type))},
        child: PlayPanel(WorkoutListParams(e.level, e.type))
      ),
    ));
    return childrens;
  }

  ClipPath buildClipPath() {
    final size = MediaQuery.of(context).size;
    final sizeClipPath = size.height * .25;
    const txtCountStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22);
    const txtDescStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white70, fontSize: 16);
    
    Widget txtHeader(String count, String text){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(count, style: txtCountStyle),
          Text(text.toUpperCase(), style: txtDescStyle),
        ],
      );
    }
    
    return ClipPath(      
          clipper: DashboardClipper(),
          child: Container(
               height: sizeClipPath,
               width: double.infinity,
               decoration: BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.bottomCenter,
                   end: Alignment.topCenter,
                   colors: [
                     Color(0xff4D5292),
                     Color(0xff252847),                   
                 ],
                 ),                         
               ),
               child: Column(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(top: sizeClipPath * .45),
                     child: Row(               
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.center, 
                        children: <Widget>[
                          txtHeader("1","трен"),
                           
                          txtHeader("2","Час")
                        ],
                      ), 
                    ),
                   
                 ],
               )
             ),
    );
  }

  Future<LevelsListModel> loadJsonData() async {
    var model = Provider.of<WorkoutsProvider>(context, listen: false);
    if(model.levelsModel == null){
      model.levelsModel = await rootBundle.loadStructuredData<LevelsListModel>('assets/json/workouts.json', (data)  async  {
        return LevelsListModel.fromJson(json.decode(data));
      });
    }
    return model.levelsModel;    
  }
}
/// Used for the dashboard          
class DashboardClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   var path = Path();
    path.lineTo(0, size.height * .3 * 2);
    path.lineTo(20, size.height * .3 * 2);
    path.quadraticBezierTo(size.width * .5, size.height, size.width-20, size.height * .3 * 2);
    path.lineTo(size.width, size.height * .3 * 2);
    path.lineTo(size.width, 0);
    
    path.moveTo(size.width, size.height);
    

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
