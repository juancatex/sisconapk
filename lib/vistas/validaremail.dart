import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class validaremail extends StatefulWidget {
  const validaremail({super.key});

  @override
  State<validaremail> createState() => _validaremailState();
}

class _validaremailState extends State<validaremail> {
  Future salir() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("debe validar su email"),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                salir();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                    child: Text(
                  "salir",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
