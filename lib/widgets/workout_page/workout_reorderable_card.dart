import 'package:flutter/material.dart';
import 'package:workout_hub/model/workout_model.dart';

class WorkoutReorderableCard extends StatefulWidget {
  final int index;
  final Key key;
  final List<WorkoutModel> listItems;

  WorkoutReorderableCard(this.listItems, this.index, this.key);
  @override
  _WorkoutReorderableCardState createState() => _WorkoutReorderableCardState();
}

class _WorkoutReorderableCardState extends State<WorkoutReorderableCard> {
  bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        //splashColor: Theme.of(context).primaryColor,
        onTap: () => /* Fluttertoast.showToast(
            msg: "Item ${widget.listItems[widget.index]} selected.",
            toastLength: Toast.LENGTH_SHORT) */{_showDialog()},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.listItems[widget.index].title}'.toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isActive ? Colors.black : Colors.grey),
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.listItems[widget.index].desc}',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.left,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    VerticalDivider(),
                    Column(
                      children: <Widget>[
                        Switch.adaptive(
                          activeColor: Color(0xff575DA4),
                          value: isActive, 
                          onChanged: (val)=>{
                            setState(() { isActive = !isActive; })
                        }),
                        Text(isActive ?  "on" : "off", style: TextStyle(fontSize: 12, color: Colors.grey),),
                      ],
                    ),                    
                    VerticalDivider(),
                    Icon(
                      Icons.reorder,
                      color: Colors.grey,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showDialog(){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titlePadding: EdgeInsets.all(0) ,
          title: Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                child: Row(                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(flex: 1, child: IconButton(icon: Icon(Icons.navigate_before, color: Colors.white,), onPressed: ()=>{},)),              
                    Flexible(flex: 2, child: Text("1/16", style: TextStyle(color: Colors.white,),)),
                    Flexible(flex: 1, child: IconButton(icon: Icon(Icons.navigate_next, color: Colors.white,), onPressed:  ()=>{})),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("jumping JACKS".toUpperCase()),),
              )
            ],
          ),
          content:Text("Text", style: TextStyle(color: Colors.grey),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}