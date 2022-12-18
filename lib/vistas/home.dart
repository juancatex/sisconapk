import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  Future salir() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL.toString()),
            ),
            Text(user.displayName.toString()),
            Text(user.email.toString()),
            Text(user.uid.toString()),
            Text(user.phoneNumber.toString()),
            Text(user.emailVerified.toString()),
            const SizedBox(
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
