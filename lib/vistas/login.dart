import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siscon/clases/decorationField.dart';

class LoginPrincipal extends StatefulWidget {
  const LoginPrincipal({super.key});

  @override
  State<LoginPrincipal> createState() => _LoginPrincipalState();
}

class _LoginPrincipalState extends State<LoginPrincipal> {
  final keyformulario = GlobalKey<FormState>();
  final correocontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  bool editarfields = true;

  Future loginfirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: correocontroller.text, password: passwordcontroller.text);
      return {'validate': true};
    } on FirebaseAuthException catch (e) {
      return {'validate': false, 'code': e.code};
    }
  }

  void mostrarmensaje(String code) {
    String mensagein = '';
    if (code == 'user-not-found') {
      mensagein = 'El correo electronico ingresado no se encuentra registrado.';
    } else if (code == 'wrong-password') {
      mensagein = 'La contrasña es incorrecta.';
    }
    ElegantNotification.error(
      showProgressIndicator: true,
      notificationPosition: NotificationPosition.bottomCenter,
      animation: AnimationType.fromBottom,
      title: const Text('Error'),
      toastDuration: const Duration(milliseconds: 7000),
      description: Text(mensagein),
    ).show(context);
  }

  void registroUser() {
    print("nuevo registro");
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.usb,
                      size: 200,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Bienvenidos",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 44),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      enabled: editarfields,
                      controller: correocontroller,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Debe ingresar un correo electrónico valido.",
                      decoration:
                          ThemaField().FieldDecoration("Correo Electrónico"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      enabled: editarfields,
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Debe ingresar una contraseña";
                        }
                        return null;
                      },
                      decoration: ThemaField().FieldDecoration("Contraseña"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RoundedLoadingButton(
                      color: Colors.deepPurple,
                      successColor: Colors.deepPurple,
                      controller: _btnController1,
                      onPressed: () {
                        if (keyformulario.currentState!.validate()) {
                          setState(() {
                            editarfields = false;
                          });
                          loginfirebase().then(
                            (value) {
                              if (!value['validate']) {
                                setState(() {
                                  editarfields = true;
                                });
                                _btnController1.reset();
                                mostrarmensaje(value['code']);
                              }
                            },
                          );
                        } else {
                          _btnController1.reset();
                        }
                      },
                      valueColor: Colors.white,
                      borderRadius: 12,
                      child: const Text("Ingresar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿No esta registrado?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: editarfields ? registroUser : null,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Registrate Aqui",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
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
