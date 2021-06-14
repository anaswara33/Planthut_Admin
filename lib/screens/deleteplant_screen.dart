import 'package:admin/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Deleteproduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data.docs.map((e) => Product.fromDoc(e)).toList();
          return Column(
            children: <Widget>[
              Text(
                "Delete Plants",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 90,
                              width: 90,
                              child: Image.network(
                                data[index].images[0],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Image.asset("assets/images/bottom_img_1.png"),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                data[index].title,
                                style: TextStyle(color: Colors.black, fontSize: 16),
                                maxLines: 2,
                              ),
                            ),
                            CloseButton(
                                color: Colors.red,
                                onPressed: () async {
                                  await removeItem(context, data[index].id);
                                })
                          ],
                        ),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> removeItem(context, String id) async {
    return await showAlertDialog(context, id);
  }

  Future<void> showAlertDialog(context, id) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove product?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is irreversible'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("products")
                    .doc(id)
                    .delete()
                    .then((value) => Fluttertoast.showToast(msg: "Product removed"))
                    .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
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
