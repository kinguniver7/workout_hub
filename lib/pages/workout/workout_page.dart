import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:workout_hub/common/constants.dart';
import 'package:workout_hub/common/helpers/workout_helpers.dart';
import 'package:workout_hub/model/params/workout_params.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkoutPage extends StatefulWidget {
  final WorkoutParams params;
  WorkoutPage(this.params);
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Stopwatch _stopwatch = new Stopwatch();
  Timer _timer;

  int _curTick = 10;
  int _maxTick;

  bool _showPreTimer; 

  bool _isStopWorkout;  
  int _curIndex = 0;

  _WorkoutPageState();

  @override
  void initState() {
    _showPreTimer = true;
    super.initState();
    
    _startTimer(_onTickPreTimer);
    /* WidgetsBinding.instance.addPostFrameCallback((_){
        
    }); */
    
  }

  @override
  Widget build(BuildContext context) {
    final curWorkout = widget.params.workouts[_curIndex];   
    return WillPopScope(
      onWillPop: _onWillPop,      
      child: Scaffold(
        appBar: AppBar(
          title: Text('workouts.${curWorkout.workoutAliase}.title').tr(),
        ),
        body: _showPreTimer ? _buildPreTimerContent() : _buildMainContent()
      ),
    );
  }
    
  Widget _buildPreTimerContent(){
    if(_maxTick == null){
      _maxTick = _curTick;
    }
    return Column(  
      mainAxisAlignment: MainAxisAlignment.center,  
      crossAxisAlignment: CrossAxisAlignment.center,  
      children: <Widget>[
          Center(
            child: CircularPercentIndicator(
              animateFromLastPercent: true,
              animation: true,
              radius: 150.0,
              lineWidth: 15.0,
              percent:  (_curTick * 100 / _maxTick) / 100 ,
              center: new Text(_curTick.toString(), style: Theme.of(context).textTheme.headline3),
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()=> setState((){
                  _addTime(10);
                }),
                child: Text(
                  "buttons.plus_10".tr().toUpperCase(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              FlatButton(
                onPressed: ()=> setState((){
                  _showPreTimer = false;
                  _startNextTimer();
                }),
                child: Text(
                  "buttons.skip".tr().toUpperCase(),
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          )
        ],
    );
  }

  Widget _buildMainContent(){
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Center(child: buildHorizontalProgres(size.width)),
        _buildCardGoTopPrev(),        
        Placeholder(),
        _buildActionButtons(),
        _buildCardGoToNext()
      ],
    );
  }
  
  Widget buildHorizontalProgres(double width) => IntervalProgressBar(
    direction: IntervalProgressDirection.horizontal,
    max: widget.params.workouts.length,
    progress: _curIndex,
    intervalSize: 2,
    size: Size(width, 5),
    highlightColor: Colors.deepOrange,
    defaultColor: Colors.grey,
    intervalColor: Colors.transparent,
    intervalHighlightColor: Colors.transparent,
    reverse: false,
    radius: 5
  );

  Widget _buildCardGoTopPrev() {
     final prevWorkout = _curIndex > 0 ?  widget.params.workouts[_curIndex - 1 ] : null;
     if(prevWorkout == null){
       return Container();
     }else{
        return Card(
          margin: EdgeInsets.all(4),
          color: Colors.white,        
          child: Container(
            height: 80,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      iconSize: 42,
                      icon: Icon(Icons.navigate_before),
                      onPressed: _onPrevCard,
                    ),
                    Text("buttons.prev", style: TextStyle(color: Colors.grey),).tr(),
                  ],
                ),
                Spacer(),                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('workouts.${prevWorkout?.workoutAliase}.title', style: Theme.of(context).textTheme.headline6,).tr(),
                    Text("${prevWorkout?.desc}", style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Placeholder(fallbackWidth: 80,),
                ),
                
              ],
              
            ),
          )
        );
     }
     
  }

  Widget _buildCardGoToNext() {
     final nextWorkout = widget.params.workouts.length-1 !=_curIndex ?  widget.params.workouts[_curIndex + 1] : null;
     return nextWorkout != null ?  Card(
        margin: EdgeInsets.all(4),
        color: Colors.white,        
        child: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Placeholder(fallbackWidth: 80,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('workouts.${nextWorkout.workoutAliase}.title', style: Theme.of(context).textTheme.headline6,).tr(),
                  Text("${nextWorkout.desc}", style: TextStyle(color: Colors.grey),),
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  IconButton(
                    iconSize: 42,
                    icon: Icon(Icons.navigate_next),
                    onPressed: _onNextCard,
                  ),
                  Text("buttons.next", style: TextStyle(color: Colors.grey),).tr(),
                ],
              ),
            ],
            
          ),
        )
      ) : 
      Card(
        margin: EdgeInsets.all(4),
        color: Colors.white,
        child: Center(
          child: RaisedButton.icon(
            onPressed: ()=>{
              _onGoToFinishPage()
            },
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            icon: Icon(Icons.done_all),
            label: Text('buttons.done_all'.tr().toUpperCase(), style: Theme.of(context).textTheme.headline5,),
          ),
        ),    
      );
  }

  Widget _buildActionButtons(){
    final curWorkout = widget.params.workouts[_curIndex];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(curWorkout.time != null ? formatSeconds(_curTick) : curWorkout.desc, style: Theme.of(context).textTheme.headline3), 
          
          Visibility(
            visible: _isStopWorkout != null,
            child: OutlineButton(
              onPressed: ()=> setState((){
                _addTime(10);
              }),
              child: Text(
                "buttons.plus_10".tr().toUpperCase(),
                style: TextStyle(fontSize: 20.0),
              ),
              shape:  RoundedRectangleBorder(            
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),       
          FlatButton(          
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            shape:  RoundedRectangleBorder(            
              borderRadius: BorderRadius.circular(12.0),
            ),      
            splashColor: Colors.blueAccent,
            onPressed: () {
              setState(() {
                if(_isStopWorkout == null){
                  _onNextCard();
                  return;
                }
                _isStopWorkout = !_isStopWorkout;
                if(_isStopWorkout){
                  _stopwatch.stop();
                }else{
                  _stopwatch.start();
                }
              });
            },
            child: _isStopWorkout == null ? Icon(Icons.done) : _isStopWorkout ? Icon(Icons.play_arrow) : Icon(Icons.pause),
          ),
        ],
      ),
    );
  }
  
  ///Represent the modal window for exit from the current screen
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => Dialog(  
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),      
        child:
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bg/hamburger.jpg'), fit: BoxFit.cover,),
            borderRadius:  BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              
              Text('Do you want to quit training?', style: Theme.of(context).textTheme.headline5,),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.redAccent,
                    onPressed: _onCloseWorkout,
                    child: new Text('buttons.quit').tr(),
                  ),
                  FlatButton(     
                    color: Colors.grey,         
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('buttons.continue').tr(),
                  ),
              ],)              
            ],
          ),
        ), 
      ),
    )) ?? false;
  }
  
  void _onGoToFinishPage(){
    Navigator.popAndPushNamed(context, Constants.ROOUTE_NAME_TO_FINISH_PAGE);
  }

  /// Presents a event go to next workout
  void _onNextCard(){   
    if(widget.params.workouts.length - 1 > _curIndex){
       setState(()=>{
        _curIndex++,  
        _showPreTimer = true,                          
      });
    _curTick = 10 ;
    _stopTimer();
   _startTimer(_onTickPreTimer);
    }else{
      _onGoToFinishPage();
    } 
  }

  /// Presents a event go to prev workout
  void _onPrevCard(){
    if(_curIndex > 0){
      setState(()=>{
        _curIndex--
      });
      _startNextTimer();
    }    
  }

  /// Presents a event go to close workout
  void _onCloseWorkout(){
    Navigator.of(context).pop(true);
  }

  void _onTickPreTimer(Timer timer) {
    setState(() {
      //_currentDuration = _stopwatch.elapsed;      
      _curTick--;
      if(_curTick < 0){
        _showPreTimer = false;
        _startNextTimer();
      }
    });    
  }
  
  void _onTickNextTimer(Timer timer) {
    if(_stopwatch.isRunning){
      setState(() {     
        _curTick--;
        if(_curTick <= 0){
          _isStopWorkout = true;
          _stopTimer();
          if(_curIndex < widget.params.workouts.length - 1){
            _onNextCard();
          }        
        }
      });    
    }    
  }

  void _startTimer(void callback(Timer timer)){
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), callback);
    _stopwatch.start();
  }

  void _stopTimer(){
    _timer?.cancel();
      _timer = null;
      _stopwatch.stop();
    setState(() {      
      //_currentDuration = _stopwatch.elapsed;
    });
  }
  
  /// Presents the method which use for go to next timer
  void _startNextTimer(){
    setState(() {
      _curTick = widget.params.workouts[_curIndex].time;
    });
   
    _stopTimer();
    if(_curTick == null){
      _isStopWorkout = null;
    }
    else{
      _isStopWorkout = false;
    }
    if(_curTick != null && _curTick > 0){
      _startTimer(_onTickNextTimer);     
    }    
  }
  
  void _addTime(int sec){
    setState(() {
      _curTick = _curTick + sec;
      _maxTick = _curTick;
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.reset();
    super.dispose();
  }

}