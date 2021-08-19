import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shop/classes/cloudDatabase.dart';
import 'package:shop/pages/home.dart';
import 'package:shop/widgets/bottom_navigation_bar.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  String? valid(value) {
    if (value!.isEmpty) {
      return "Password required";
    } else if (value.length < 6) {
      return "Should be at least 6 charcater";
    } else if (value.length > 15) {
      return "Should not be more than 15 charcater";
    }
    return null;
  }

  final formkey = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  late String _name, _email, _password;
  late CloudDatabase db;
  List data = [];

  Initialize() {
    db = CloudDatabase();
    db.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          "Create account",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage("assets/shops.png")),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter your name ",
                              labelText: "name",
                              border: OutlineInputBorder(),
                            ),
                            validator:
                                RequiredValidator(errorText: "Name required"),
                            onChanged: (value) {
                              _name = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter your email address",
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                            validator: MultiValidator([
                              EmailValidator(errorText: "Invalid email"),
                              RequiredValidator(errorText: "Email required"),
                            ]),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter your password address",
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: valid,
                            onChanged: (value) {
                              _password = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            width: 350,
                            height: 50,
                            child: ElevatedButton(
                              child: Text(
                                "Sign Up",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  try {
                                    UserCredential credential = await instance
                                        .createUserWithEmailAndPassword(
                                            email: _email, password: _password);
                                    db.create(_name, _email).then((_) => {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigtion(
                                                        Email: _email,
                                                      )))
                                        });
                                  } on FirebaseAuthException catch (e) {
                                    print("error");
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
