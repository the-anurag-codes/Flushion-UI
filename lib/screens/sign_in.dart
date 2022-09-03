import 'package:ecommerce_fash_app/screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  late SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;


  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedIn = await _googleSignIn.isSignedIn();

    if (isLogedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleUser?.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential userCredential =
        await _auth.signInWithCredential(authCredential);
    User? user = userCredential.user;

    if (user != null) {
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();

      final List<DocumentSnapshot> document = result.docs;
      UserDetails().userName = user.displayName;
      UserDetails().email = user.displayName;

      if (document.length == 0) {
        // Insert the user to the collection
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "profilePic": user.photoURL
        });

        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName ?? "");
        await preferences.setString("profilePic", user.photoURL ?? "");
      } else {
        await preferences.setString("id", document[0]["id"]);
        await preferences.setString("username", document[0]["username"]);
        await preferences.setString("profilePic", document[0]["profilePic"]);
      }

      Fluttertoast.showToast(msg: "LoggedIn Successfully!");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Fluttertoast.showToast(msg: "Login Failed :(");
    }
  }

  void logOut() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 80.0,
            ),
            child: Container(
              child: Image.asset('assets/lg.png'),
              width: 250.0,
              height: 250.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15.0),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null) {
                                    String pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\'
                                        r'.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\'
                                        r'.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|('
                                        r'([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value!))
                                      return 'Please make sure your email address '
                                          'is valid';
                                    else
                                      return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
                                  border: InputBorder.none,
                                  hoverColor: Colors.red
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Password Text Field
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15.0),
                            // elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "The password field can not be empty";
                                  } else if (value.length < 6) {
                                    return "The password has to be at least 6 "
                                        "characters long";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        padding:
                            EdgeInsets.only(right: 18.0, top: 8.0, bottom: 8.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.shade700,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () {
                              handleSignIn();
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                  letterSpacing: 0.2,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Sign up!",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      ),

                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: Divider(
                                color: Colors.white,
                                height: 60,
                              )),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: Divider(
                                color: Colors.white,
                                height: 60,
                              )),
                        ),
                      ]),

                      // Google Sign In Button
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () {
                              handleSignIn();
                            },
                            textColor: Colors.black,
                            minWidth: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/google.png",
                                  width: 25,
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80),
                                  child: Text(
                                    'Sign in with google ',
                                    style: TextStyle(
                                      letterSpacing: 0.2,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Visibility(
              visible: loading,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class UserDetails{
  String? userName;
  String? email;
}