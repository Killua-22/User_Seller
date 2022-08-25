// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:user_seller/screens/User/FilterScreen.dart';

class UserScreen extends StatefulWidget {
  final int? range;
  const UserScreen({Key? key, this.range}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Query _ref;
  // late DatabaseReference reference;
  late double lower_Limit;
  late double upper_Limit;

  void initState() {
    super.initState();
    switch (widget.range) {
      case 1:
        lower_Limit = 0;
        upper_Limit = 1000;
        break;
      case 2:
        lower_Limit = 1000;
        upper_Limit = 5000;
        break;
      case 3:
        lower_Limit = 5000;
        upper_Limit = 10000;
        break;

      case 4:
        lower_Limit = 10000;
        upper_Limit = 2e10 + 1;
        break;

      default:
        lower_Limit = 0;
        upper_Limit = 2e10 + 1;
    }
    print(lower_Limit);
    print(upper_Limit);
    _ref = FirebaseDatabase(
            databaseURL:
                "https://userseller-1beae-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("User")
        .orderByChild('price')
        .startAt(lower_Limit)
        .endAt(upper_Limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterScreen(),
                    ));
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: FirebaseAnimatedList(
            query: _ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map product = snapshot.value as Map;
              print(product['price']);
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        isThreeLine: true,
                        title: Text(
                          product["name"],
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 63, 58, 58),
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(children: [
                                Text("Brand: "),
                                SizedBox(width: 6),
                                Text(
                                  product["brand"],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 84, 75, 75),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Price: "),
                                SizedBox(width: 6),
                                Text(
                                  product["price"].toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 84, 75, 75),
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  // SizedBox(width: 70),
                                  Text(
                                    "Category: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 84, 75, 75),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    product["category"],
                                    style: TextStyle(
                                        fontSize: 12,
                                        // color: statusColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
