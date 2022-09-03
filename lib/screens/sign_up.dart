import 'package:ecommerce_fash_app/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../database/users.dart';

import 'home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserServices _userServices = UserServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController =
  TextEditingController();
  late SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;
  bool hidePass = true;
  late String gender;
  String groupValue = "male";

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
    isLoggedIn = await _googleSignIn.isSignedIn();

    if (isLoggedIn) {
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

      if (document.length == 0) {
        // Insert the user to the collection
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "prfilePic": user.photoURL
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
              left: 80.0,
            ),
            child: Container(
              child: Image.asset('assets/lg.png'),
              width: 250.0,
              height: 250.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15.0),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _nameTextController,
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  icon: Icon(Icons.person_outline),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "The name field can not be empty";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "male",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Radio(
                                  focusColor: Colors.grey,
                                  activeColor: Colors.grey,
                                  value: "male",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "female",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Radio(
                                  focusColor: Colors.grey,
                                  activeColor: Colors.grey,
                                  value: "female",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.7),
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
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Password Text Field
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15.0),
                            // elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
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
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = hidePass ? false : true;
                                    });
                                  },),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Confirm Password Text Field
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15.0),
                            // elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _confirmpasswordTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "The password field can not be empty";
                                    } else if (value.length < 6) {
                                      return "The password has to be at least 6 "
                                          "characters long";
                                    } else
                                    if (_passwordTextController.text != value) {
                                      return "The passwords do not match";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = hidePass ? false : true;
                                    });
                                  },),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Login Button
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.shade700,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              validateForm();
                            },
                            minWidth: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  letterSpacing: 0.2,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
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
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                "Log  in!",
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
                                height: 50,
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
                                height: 50,
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
                            minWidth: MediaQuery
                                .of(context)
                                .size
                                .width,
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
                                    'Sign up with google ',
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

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState? formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.reset();
      User? user = _auth.currentUser;
      if (user == null) {
        _auth.createUserWithEmailAndPassword(email: _emailTextController.text,
            password: _passwordTextController.text).then((user) =>
        {
          _userServices.createUser(
              {
          "username": user.user?.displayName,
            "email": user.user?.email,
            "userId": user.user?.uid,
            "gender": gender,
          })
        }).catchError((e)=> print(e.toString()));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }
}
