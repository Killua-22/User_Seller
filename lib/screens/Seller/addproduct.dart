// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class addproduct extends StatefulWidget {
  final String email;
  const addproduct({Key? key, required this.email}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  late TextEditingController _nameController,
      _brandController,
      _priceController;

  late DatabaseReference _ref;
  late DatabaseReference _userref;

  List<String> Category = [
    "Electronics",
    "Consumer Durables",
    "Beauty",
    "Toys and Games",
    "Fashion and Clothing"
  ];

  String _category = "Electronics";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _brandController = TextEditingController();
    _priceController = TextEditingController();
    _ref = FirebaseDatabase(
            databaseURL:
                "https://userseller-1beae-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("Seller")
        .child(widget.email.split('.')[0]);

    _userref = FirebaseDatabase(
            databaseURL:
                "https://userseller-1beae-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("User");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Post Product")),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              children: [
                Text("Name:"),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Brand"),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _brandController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Price"),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Category"),
                SizedBox(width: 10),
                DropdownButton(
                  value: _category,
                  items: Category.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.redAccent,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: size.height * 20 / 800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                onPressed: () async {
                  save();
                },
                child: const Text(
                  "Post Product",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  void save() {
    String name = _nameController.text;
    String brand = _brandController.text;
    int price = int.parse(_priceController.text);

    Map<String, dynamic> product = {
      "name": name,
      "brand": brand,
      "price": price,
      "category": _category,
    };

    _userref.push().set(product);
    _ref.push().set(product).then((value) {
      Navigator.pop(context);
      print("Done push");
    });
  }
}
