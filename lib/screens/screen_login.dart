import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_seller/screens/Seller/SellerScreen.dart';
import 'package:user_seller/screens/User/UserScreen.dart';
import 'package:user_seller/screens/screen_signup.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found");
      }
    }
    return user;
  }

  getStringValuesSF(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(email);
    return stringValue;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 50 / 360,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 70 / 800,
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 49, 49, 49),
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 100 / 800,
                ),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email address",
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28))),
                ),
                SizedBox(
                  height: size.height * 16 / 800,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.password, color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                ),
                SizedBox(height: size.height * 16 / 800),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    fillColor: Colors.redAccent,
                    elevation: 0,
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 20 / 800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    onPressed: () async {
                      User? user = await loginUsingEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                      String usertype =
                          await getStringValuesSF(_emailController.text);

                      print(user);
                      print(usertype);
                      if (user != null) {
                        if (usertype == 'user') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => UserScreen()));
                        } else if (usertype == 'seller') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SellerScreen(
                                      email: _emailController.text)));
                        }
                      }
                    },
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Dont have an account?",
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
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
