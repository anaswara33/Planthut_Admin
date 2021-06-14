
import 'package:admin/screens/deliveryboy_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DeliveryboyScreen extends StatefulWidget {
  @override
  DeliveryboyScreenState createState() => new DeliveryboyScreenState();
}

class DeliveryboyScreenState extends State<DeliveryboyScreen>{

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Delivery boys"),
      ),
      body: Deliveryboyuser(),
    );
  }
}
