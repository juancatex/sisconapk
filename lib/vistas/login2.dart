import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:siscon/clases/decorationField.dart';
import 'package:siscon/clases/header_widget.dart';

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
  bool vistapass = false;
  double _headerHeight = 150;
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.blue.shade900,
          Color.fromARGB(255, 108, 184, 247),
          Color.fromARGB(255, 245, 58, 161)
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true,
                    Icons.login_rounded), //let's create a common header widget
              ),
              Center(
                child: Form(
                  key: keyformulario,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: SimpleShadow(
                                      child: Image.asset('assets/logo.png',
                                          width: 200),
                                      opacity: 0.6, // Default: 0.5
                                      color: Colors.black, // Default: Black
                                      offset:
                                          Offset(3, 3), // Default: Offset(2, 2)
                                      sigma: 7, // Default: 2
                                    )),
                                const Text(
                                  "ASCINALSS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 48,
                                      fontFamily: "Anton",
                                      shadows: [
                                        Shadow(
                                            color: Color.fromARGB(
                                                255, 95, 117, 243),
                                            offset: Offset(2.5, 2.5))
                                      ]),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  enabled: editarfields,
                                  controller: correocontroller,
                                  validator: (value) => EmailValidator.validate(
                                          value!)
                                      ? null
                                      : "Debe ingresar un correo electrónico valido.",
                                  decoration: ThemaField()
                                      .FieldDecoration("Correo Electrónico"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: !vistapass,
                                  enabled: editarfields,
                                  controller: passwordcontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Debe ingresar una contraseña";
                                    }
                                    return null;
                                  },
                                  decoration: ThemaField().FieldPassDecoration(
                                      "Contraseña",
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            vistapass = !vistapass;
                                          });
                                        },
                                        icon: Icon(vistapass
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                RoundedLoadingButton(
                                  color: Color.fromARGB(255, 44, 70, 212),
                                  successColor:
                                      Color.fromARGB(255, 44, 70, 212),
                                  controller: _btnController1,
                                  onPressed: () {
                                    if (keyformulario.currentState!
                                        .validate()) {
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: editarfields ? registroUser : null,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
