import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:share/share.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/widgets/left_drawer.dart';

class FinishPage extends StatefulWidget {
  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  ConfettiController _controllerTopCenter;
  @override
  void initState() {    
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));   
        _controllerTopCenter.play(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      drawer: LeftDrawer(),
      body: CustomScrollView(  
          
        slivers: <Widget>[         
           SliverFixedExtentList(
            itemExtent: 0.000001,
            delegate: SliverChildListDelegate(
              [
                buildConfetti(),
              ],
            )
            ),
          SliverAppBar(
            centerTitle: true,
            //title: Text("data"),
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: buildFlexibleSpaceBar(context),
            expandedHeight: 250,
          ),
          
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Text("Weight", style: Theme.of(context).textTheme.headline6,),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0.00 KG",
                    ),
                  ),
                  Divider(),
                  Text('I feel',style: Theme.of(context).textTheme.headline6,),
                  SizedBox(height: 8),
                  ReviewSlider(
                    onChange: (val){},
                    options: [
                      "feelings.angry".tr(),
                      "feelings.tired".tr(),
                      "feelings.okay".tr(),
                      "feelings.good".tr(),
                      "feelings.excited".tr(),
                    ],
                  ),
                  Text("Notes", style: Theme.of(context).textTheme.headline6,),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Type your notest here",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
        
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton.icon(
          
          onPressed: _onSave,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          icon: Icon(Icons.playlist_play),
          label: Text('buttons.save'.tr().toUpperCase(), style: Theme.of(context).textTheme.headline5,),
        ),
      ), 
    );
  }

  FlexibleSpaceBar buildFlexibleSpaceBar(BuildContext context) {
    return FlexibleSpaceBar(              
            background: Container(                  
                decoration: BoxDecoration(
                  //image: DecorationImage(image: AssetImage(getAppBarBackgroundImage(widget.params)), fit: BoxFit.cover,)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[                      
                    Padding(
                      padding: const EdgeInsets.only(top:60),
                      child: Column(
                        children: <Widget>[
                          SvgPicture.asset('assets/icons/trophy.svg', height: 130,),
                          OutlineButton(
                            textColor: Colors.white,
                            disabledBorderColor: Colors.orange,
                            focusColor: Colors.orange,
                            highlightColor: Colors.orange,
                            highlightedBorderColor: Colors.orange,
                            borderSide: BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: ()=>{Share.share('labels.share.text'.tr(), subject: 'labels.share.subject')},
                            child: Text("buttons.share".tr().toUpperCase()),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("labels.duration", style: Theme.of(context).textTheme.headline5,).tr(),
                            Text("00:20", style: Theme.of(context).textTheme.headline5,)
                          ],
                        ),
                        
                        Column(
                          children: <Widget>[
                            Text("labels.kcal", style: Theme.of(context).textTheme.headline5,).tr(),
                            Text("54.0", style: Theme.of(context).textTheme.headline5,)
                          ],
                        )

                      ],
                    )
                    
                  ],
                ),                  
              ),
            //padding: EdgeInsets.only(bottom: 100),
          );
  }

  Align buildConfetti() {
    return Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: false,
              colors: const [
                Colors.pink,
                Colors.green,
                Colors.deepOrange,
                Colors.lime,
                Colors.yellowAccent,              
                Colors.purple,
                
              ], // manually specify the colors to be used
            ),
          );
  }
 
  void _onSave(){
    Navigator.pushNamedAndRemoveUntil(context, Constants.ROOUTE_NAME_TO_INIT_PAGE, (r) => false);
  }
   
  @override
  void dispose() {    
    _controllerTopCenter.dispose();
    super.dispose();
  }
}