// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:user_seller/screens/Seller/addproduct.dart';

class SellerScreen extends StatefulWidget {
  final String? email;
  const SellerScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  late Query _ref;
  // late DatabaseReference reference;

  void initState() {
    super.initState();
    _ref = FirebaseDatabase(
            databaseURL:
                "https://userseller-1beae-default-rtdb.asia-southeast1.firebasedatabase.app")
        .ref()
        .child("Seller")
        .child(widget.email!.split('.')[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map product = snapshot.value as Map;
            // var key = snapshot.key;
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
                                  "Catergory: ",
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addproduct(email: widget.email!),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
