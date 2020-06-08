import 'package:flutter/material.dart';
import 'package:workout_hub/widgets/common/calories_indicator.dart';

class TodayPanel extends StatefulWidget {
  @override
  _TodayPanelState createState() => _TodayPanelState();
}

class _TodayPanelState extends State<TodayPanel> {
    
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
        color: Colors.white,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,          
          children: <Widget>[
            buildTopContainer(),
            buildBodyContainer()            
          ],),
      ),
    );
  }

  Container buildBodyContainer() {
    return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ConstrainedBox(constraints: BoxConstraints(minWidth: 65), child: txtHeader("Сожжено","650","кал."),),
                CaloriesIndicator(),                
                ConstrainedBox(constraints: BoxConstraints(minWidth: 65), child: txtHeader("Цель", "1300","кал."),),
            ],)
          ,);
  }

  Container buildTopContainer() {
    return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              //prew button
              FlatButton(
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black12)
                ),
                child: Icon(Icons.navigate_before),
                onPressed: () {                    
                },
              ),
              //TODAY button
              FlatButton(
                child: Text("TODAY"),
                onPressed: () {                    
                },
              ),
              //next button
              FlatButton(
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black12)
                ),
                child: Icon(Icons.navigate_next),
                onPressed: () {                    
                },
              ),
            ],)
          ,);
  }
  
  Widget txtHeader(String desc, String count, String text){
    final txtCountStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 28);
    final txtDescStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black26, fontSize: 16);
    
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(desc.toUpperCase(), style: txtDescStyle),
          Text(count, style: txtCountStyle),
          Text(text, style: txtDescStyle),
        ],
      );
    }
}