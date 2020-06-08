import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workout_hub/widgets/home_page/today_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(  
            alignment: Alignment.center,          
            children: <Widget>[
              buildClipPath(),
              Positioned(
                bottom: 0,
                child: SvgPicture.asset("assets/coach/man_1.svg", height: 150,  )           
              ),         
            ],
          ),
          Center(
            child: FlatButton(
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black12)
                ),
                child: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {                    
                },
              ),
          ),
          TodayPanel()   
        ],
      ),      
    );
  }
  
  ClipPath buildClipPath() {
    final size = MediaQuery.of(context).size;
    final sizeClipPath = size.height * .4;
    const txtCountStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28);
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
                     Color(0xff4d5aea),
                     Color(0xff252847),                   
                 ],
                 ),                         
               ),
               child: Column(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(top: sizeClipPath * .2),
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
