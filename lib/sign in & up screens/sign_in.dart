import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shop/pages/home.dart';
import 'package:shop/widgets/bottom_navigation_bar.dart';
import 'sign_up.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
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
  late String _email, _password;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "DSC Shop",
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/shops.png"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 10,
                    child: Column(
                      children: [
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
                              RequiredValidator(
                                  errorText: "Please enter email"),
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
                                "Sign In",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  try {
                                    await instance
                                        .signInWithEmailAndPassword(
                                            email: _email, password: _password)
                                        .then((_) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigtion(
                                                    Email: _email,
                                                  )));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("User not found"),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {},
                                        ),
                                      ));
                                    } else if (e.code == 'wrong-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Wrong Password"),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {},
                                        ),
                                      ));
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SingUp()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
