import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                style: TextStyle(fontSize: 22, color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                style: TextStyle(fontSize: 22, color: Colors.black),
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: ()  {
                         _firebaseAuth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text).then((value) {
                            FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set({"email" : value.user!.email,"UID":value.user!.uid});
                        });
                      },
                      child: Text(
                        'Register',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: ()  {
                         _firebaseAuth
                            .signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((value) => print("login"));
                      },
                      child: Text(
                        'Login',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
