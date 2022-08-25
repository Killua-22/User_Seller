// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Seller/SellerSignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _zipcodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  late bool _success;
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _register() async {
      final User user = (await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user!;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_emailController.text, "user");
    }

    return Material(
      child: Container(
        color: Colors.white,
        height: 1000,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 90.0),
                  const Text(
                    "Create your account!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 49, 49, 49),
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Not a User? Sign up as a Merchant: ",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.0,
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        " Sign up",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SellerSignUpScreen(),
                            ));
                      },
                    ),
                  ]),
                  const SizedBox(height: 50.0),
                  const SizedBox(height: 22.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(height: 22.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Age",
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _zipcodeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "Zip Code",
                          prefixIcon: Icon(Icons.confirmation_number_sharp,
                              color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon:
                              Icon(Icons.location_city, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _genderController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Gender",
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: 300,
                    child: RawMaterialButton(
                      fillColor: Colors.redAccent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      onPressed: () async {
                        _register();

                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    child: const Text(
                      "Go back?",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
