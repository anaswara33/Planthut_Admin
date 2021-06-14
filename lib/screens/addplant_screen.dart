import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Addproduct extends StatefulWidget {
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final _formKey = GlobalKey<FormState>();
  String name;
  List<String> images = [];
  String description;
  List<int> colors = [];
  int rating, price;

  TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        "Add Plant",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Plant Name",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) => name = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Plant description",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) => description = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Plant price",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) => price = int.tryParse(value),
                      validator: (value) {
                        if (value.isEmpty || int.tryParse(value) == null) {
                          return "Enter valid price";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Plant rating",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      onSaved: (value) => rating = int.tryParse(value),
                      validator: (value) {
                        final val = int.tryParse(value);
                        if (value.isEmpty || val == null || val > 10 || val < 0) {
                          return "Enter valid rating";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: images.isNotEmpty,
                      child: Container(
                        height: 75,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return buildSmallProductPreview(index);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Plant images",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _imageController,
                            validator: (value) {
                              if (value.isEmpty && images.isEmpty) {
                                return "Enter valid image url";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[400]),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[400]))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (_imageController.text.isNotEmpty) {
                                    images.add(_imageController.text);
                                    _imageController.clear();
                                  }
                                });
                              },
                              child:
                                  Text("Add", style: TextStyle(fontSize: 18, color: Colors.green))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      colors.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        shape: BoxShape.circle,
                                        color: Color(colors[index])),
                                    child: Icon(Icons.close, color: Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () async {
                                await getColorFromDialog(context);
                                print(colors);
                              },
                              child: Icon(Icons.add, color: Colors.green),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        await addPlant(context);
                      }
                    },
                    color: Color(0xFF33691E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "ADD product",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSmallProductPreview(int index) {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image.network(
          images[index],
          fit: BoxFit.cover,
          height: 48,
          width: 48,
          filterQuality: FilterQuality.low,
          errorBuilder: (_, __, ___) =>
              Image.asset("assets/images/bottom_img_1.png", height: 48, width: 48),
        ),
      ),
      InkWell(
        onTap: () {
          setState(() {
            images.removeAt(index);
          });
        },
        child: Icon(Icons.close),
      ),
    ]);
  }

  Future<int> getColorFromDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        Color selectedColor = Colors.white;
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              onColorChanged: (color) {
                selectedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
              pickerColor: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() => colors.add(selectedColor.value));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addPlant(BuildContext context) async {
    final progress = ProgressDialog(context);
    try {
      progress.show();
      await FirebaseFirestore.instance.collection("products").add({
        'title': name,
        'rating': rating,
        'price': price,
        'description': description,
        'images': images,
        'colors': colors
      }).then((value) async {
        progress.hide();
        Fluttertoast.showToast(msg: "Product added!");
        Navigator.pop(context);
      });
    } catch (e) {
      progress.hide();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
