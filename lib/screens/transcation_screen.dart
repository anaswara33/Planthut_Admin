import 'package:admin/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TranscationScreen extends StatefulWidget {
  _TranscationScreenState createState() => _TranscationScreenState();
}

class _TranscationScreenState extends State<TranscationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("orders").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data.docs.map((e) => Order.fromDoc(e)).toList();
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) => Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Order ID: ${data[index].orderId}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            Text("₹${data[index].total}", style: TextStyle(color: Colors.green)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Placed on: " + DateFormat.yMd().format(data[index].date),
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<DocumentSnapshot>(
                                future: data[index].uid.get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  if (snapshot.hasData && !snapshot.data.exists) {
                                    return Text("Document does not exist");
                                  }

                                  if (snapshot.connectionState == ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data.data();
                                    return Text(
                                      "Customer: "
                                      "${data['fname']} ${data['lname']}\n"
                                      "Address: ${data['address']}",
                                    );
                                  }

                                  return Text("loading");
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            data[index].delivery != null
                                ? FutureBuilder<DocumentSnapshot>(
                                    future: data[index].delivery.get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text("Something went wrong");
                                      }

                                      if (snapshot.hasData && !snapshot.data.exists) {
                                        return Text("Document does not exist");
                                      }

                                      if (snapshot.connectionState == ConnectionState.done) {
                                        Map<String, dynamic> data = snapshot.data.data();
                                        return Text(
                                          "Delivery boy: "
                                          "${data['fname']} ${data['lname']}\n"
                                          "Delivery boy phone: ${data['phone']}",
                                        );
                                      }

                                      return Text("loading");
                                    })
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Items:${getItemsString(data[index].items)}",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  String getItemsString(List<Item> items) {
    String string = "";
    items.forEach((element) {
      string = string + "\n. ${element.pName} x${element.quantity}";
    });
    return string;
  }
}
