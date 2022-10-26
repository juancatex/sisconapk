import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:siscon/vistas/home.dart';
import 'package:siscon/vistas/login2.dart';
import 'package:siscon/vistas/validaremail.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Color _primaryColor = HexColor('#101DE9'); //izquierda
  Color _accentColor = HexColor('#82A3FC'); //derecha
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        primarySwatch: Colors.deepPurple, // color de la seleccion
      ),
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.emailVerified) {
                return Home();
              } else {
                return validaremail();
              }
            } else {
              return LoginPrincipal();
            }
          },
        ),
      ),
    );
  }
}
