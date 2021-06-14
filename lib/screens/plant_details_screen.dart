import 'package:admin/screens/addplant_screen.dart';
import 'package:admin/screens/deleteplant_screen.dart';
import 'package:admin/screens/view_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlantScreen extends StatefulWidget {
  @override
  PlantScreenState createState() => new PlantScreenState();
}

class PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text("Manage Plants"),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              new RaisedButton(
                  elevation: 0.0,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  padding: EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ViewProducts();
                      }),
                    );
                  },
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: new Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        "View Plants",
                        style: TextStyle(
                            fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  textColor: Color(0xFF292929),
                  color: Colors.green),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                child: new RaisedButton(
                    elevation: 0.0,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Addproduct();
                        }),
                      );
                    },
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: new Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        new Text(
                          "Add Plant",
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    textColor: Color(0xFF292929),
                    color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                // ignore: deprecated_member_use
                child: new RaisedButton(
                    elevation: 0.0,
                    shape:
                        new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    padding: EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Deleteproduct();
                        }),
                      );
                    },
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: new Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        new Text(
                          "Delete / Remove Plant",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0),
                        )
                      ],
                    ),
                    textColor: Color(0xFF292929),
                    color: Colors.red),
              ),
            ],
          ),
        ));
  }
}
