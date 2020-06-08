import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CaloriesIndicator extends StatefulWidget {
  @override
  _CaloriesIndicatorState createState() => _CaloriesIndicatorState();
}

class _CaloriesIndicatorState extends State<CaloriesIndicator> with SingleTickerProviderStateMixin  {
  //AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    /* _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
 
    _animationController.addListener(() => setState(() {})); */
    /*_animationController.repeat(); */
  }

  @override
  Widget build(BuildContext context) {
    //final percentage = _animationController.value * 100;
    final value = .5;
    
    return Column(
      children: <Widget>[
        LiquidCustomProgressIndicator(
          value: value,//_animationController.value,
          direction: Axis.vertical,
          backgroundColor: Colors.black12,
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
          shapePath: _buildBurnPath(),
        
        ),
        Center(child: Text("50%", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26, fontSize: 16),),)
    ],); 
  }

  
  Path _buildBurnPath() {
    return Path()
      ..moveTo(22.6285, 131.432)
      ..cubicTo(28, 136, 21, 113, 24, 101)
      ..cubicTo(26.1786, 95.9731, 29.0846, 90.3108,34.134, 85.8566)
      ..cubicTo(34.134, 85.8566, 33.9197, 107.0134,47.8134, 120.2969)
      ..cubicTo(47.8134, 120.2969, 47.3552, 112.8795, 54.9942, 98.4378)
      ..cubicTo(63.1313, 83.0527,57.0656, 62.5161, 57.0656, 62.5161)
      ..cubicTo(57.0656, 62.5161, 69.7018, 74.3232,76.2055, 91.9643)
      ..cubicTo(79.5395, 87.7587, 81.9969, 85.6698, 81.6311, 86.616)
      ..cubicTo(79.3129, 92.6194, 80.5132, 97.0837, 82.4378, 101.5082)
      ..cubicTo(84.6612, 106.6152, 87.8533, 111.6695, 81, 131)
      ..cubicTo(84, 133, 107.3965, 115.828, 107.5457, 102.1957)
      ..cubicTo(107.695, 88.5634, 96.4111, 82.772, 101.4032, 69.8392)
      ..cubicTo(101.8665, 68.6417, 97.8055, 72.3044, 93.154, 78.9972)
      ..cubicTo(82.0921, 30.6407, 34.3757, 0, 34.3757, 0)
      ..cubicTo(34.3757, 0 , 56.1327, 24.9963, 48.0826, 49.863)
      ..cubicTo(40.0352, 74.7297, 44.9477, 89.674, 44.9477, 89.674)
      ..cubicTo(30.962, 70.5566, 38.1405, 39.5895, 38.1405, 39.5895)
      ..cubicTo(24.9815, 51.1974, 17.7133, 65.5741, 13.7768, 77.72)
      ..cubicTo(9.8006, 71.8388, 6.5013, 68.7213, 6.9321, 69.842)
      ..cubicTo(11.9242, 82.7748, 0.6399, 88.5662, 0.7896, 102.1985)
      ..cubicTo(0.9411, 115.828, 22, 131, 22.6285, 131.432)
      ..close();
  }

  @override
  void dispose() {
    //_animationController.dispose();
    super.dispose();
  }
}