// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_seller/screens/User/UserScreen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int range = -1;
  int _checkbox = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Filter"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Price",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                _checkBox("0 to Rs.1000", 1),
                _checkBox("Rs.1000 to Rs.5000", 2),
                _checkBox("Rs.5000 to Rs.10000", 3),
                _checkBox("Rs.10000+", 4)
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserScreen(range: range)));
                },
                child: const Text(
                  "Filter",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget _checkBox(String text, int id) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_checkbox == id) {
            _checkbox = 0;
            range = id;
          } else {
            _checkbox = id;
            range = id;
          }
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Container(
                  height: 10,
                  width: 10,
                  decoration: _checkbox == id
                      ? BoxDecoration()
                      : BoxDecoration(
                          border: Border.all(
                          color: Colors.black,
                        )),
                  child: _checkbox == id
                      ? Icon(Icons.check_box, color: Colors.blue, size: 20)
                      : null),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )),
    );
  }
}
