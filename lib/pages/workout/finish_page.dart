import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text("finish_page.title").tr(),
        ),
        body: Column(
          children: <Widget>[            
            buildConfetti(),
            Text("data"),
          ],
        )
      );
  }

  Align buildConfetti() {
    return Align(
            alignment: Alignment.center,
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

  @override
  void dispose() {    
    _controllerTopCenter.dispose();
    super.dispose();
  }
}