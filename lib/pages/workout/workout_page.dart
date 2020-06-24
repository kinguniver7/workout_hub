import 'package:flutter/material.dart';
import 'package:intervalprogressbar/intervalprogressbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:workout_hub/model/params/workout_params.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quiver/async.dart';

class WorkoutPage extends StatefulWidget {
  final WorkoutParams params;
  WorkoutPage(this.params);
  @override
  _WorkoutPageState createState() => _WorkoutPageState(true);
}

class _WorkoutPageState extends State<WorkoutPage> {
  bool _showTimer;
  int _currentTick = 10;
  int _startTick = 10;
  int _curIndex = 0;

  _WorkoutPageState(this._showTimer);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
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
        body: _showTimer ? _buildStartContent() : _buildContent()
      ),
    );
  }

  Widget _buildStartContent(){
    return Column(  
      mainAxisAlignment: MainAxisAlignment.center,    
      children: <Widget>[
          Center(
            child: CircularPercentIndicator(
              animateFromLastPercent: true,
              animation: true,
              radius: 150.0,
              lineWidth: 15.0,
              percent: _currentTick * _startTick / 100,
              center: new Text(_currentTick.toString(), style: Theme.of(context).textTheme.headline3,),
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
          FlatButton(
            onPressed: stopTimer,
            child: Text(
              "buttons.skip",
              style: TextStyle(fontSize: 20.0),
            ).tr(),
          )
        ],
    );
  }

  Widget _buildContent(){
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Center(child: buildHorizontal(size.width)),
        
        Placeholder(),
        Card(
          margin: EdgeInsets.all(4),
          color: Colors.white,
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Up Next"),
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Placeholder(fallbackHeight: 100, fallbackWidth: 100,),
                  Text("x16")

                ]
              ),
            ],
          ),
        )
      ],
    );
  }

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
                    onPressed: _closeWorkout,
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
  
  Widget buildHorizontal(double width) => IntervalProgressBar(
    direction: IntervalProgressDirection.horizontal,
    max: widget.params.workouts.length,
    progress: 1,
    intervalSize: 2,
    size: Size(width, 5),
    highlightColor: Colors.deepOrange,
    defaultColor: Colors.grey,
    intervalColor: Colors.transparent,
    intervalHighlightColor: Colors.transparent,
    reverse: false,
    radius: 5);

  void _closeWorkout(){
    Navigator.of(context).pop(true);
  }

  void startTimer() {
  CountdownTimer countDownTimer = new CountdownTimer(
    new Duration(seconds: 10),
    new Duration(seconds: 1),
  );

  var sub = countDownTimer.listen(null);
  sub.onData((duration) {
    setState(() { _currentTick = _startTick - duration.elapsed.inSeconds; });
  });

  sub.onDone(() {
    stopTimer();
    sub.cancel();
  });
}

  void stopTimer(){
    setState(() {
      _showTimer = false;
      if(_currentTick>0){
        _currentTick = 0;
      }
    });
    

  }
}