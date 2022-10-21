import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPrincipal extends StatefulWidget {
  const LoginPrincipal({super.key});

  @override
  State<LoginPrincipal> createState() => _LoginPrincipalState();
}

class _LoginPrincipalState extends State<LoginPrincipal> {
  final keyformulario = GlobalKey<FormState>();
  final correocontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  Future loginfirebase() async {
    print(correocontroller.text);
    print(passwordcontroller.text);
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: correocontroller.text, password: passwordcontroller.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    correocontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Form(
          key: keyformulario,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.usb,
                      size: 200,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Bienvenidos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 44),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        controller: correocontroller,
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Debe ingresar un correo electronico valido.",
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 19)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Debe ingresar una contraseña";
                          }
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (keyformulario.currentState!.validate()) {
                          loginfirebase();
                        } else {}
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            "Ingresar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿No esta registrado?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Registrate AQUI",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
