import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_hub/common/helpers/workout_helpers.dart';
import 'package:workout_hub/model/params/workout_lits_params.dart';

class PlayPanel extends StatelessWidget {
  //final String title;
  //final String bgImage;
  //final String rateImage;
  final WorkoutListParams params;
  PlayPanel(this.params);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 140,      
            child: Card(  
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,      
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
              color: Colors.white,
              margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
              elevation: 5,
              child: Hero(
                tag: "${params.type}_${params.level}",
                child: Container( 
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getAppBarBackgroundImage(params)),
                      fit: BoxFit.cover,
                      
                    ) ,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(getLevelTitle(params), style: Theme.of(context).textTheme.headline5,), 
                          )              
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(getLevelImage(params), height: 32,),
                      )
                    ],
                  ) 
                ),
              )         
            ),
      );
    
  }

}