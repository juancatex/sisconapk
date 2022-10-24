import 'package:flutter/material.dart';

class ThemaField {
  // ignore: non_constant_identifier_names
  InputDecoration FieldDecoration(String nombre) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      labelText: nombre,
      fillColor: Colors.white38,
      filled: true,
      // labelStyle: const TextStyle(fontSize: 17),
      // floatingLabelStyle: TextStyle(color: Colors.blue),
      // errorStyle: TextStyle(color: Colors.red),
      // focusedBorder: const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
      //     borderSide: BorderSide(color: Colors.blue)),
      // enabledBorder: const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
      //     borderSide: BorderSide(color: Colors.black38))
    );
  }

  InputDecoration FieldPassDecoration(String nombre, Widget vista) {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        labelText: nombre,
        fillColor: Colors.white38,
        filled: true,
        suffixIcon: vista
        // labelStyle: const TextStyle(fontSize: 17),
        // floatingLabelStyle: TextStyle(color: Colors.blue),
        // errorStyle: TextStyle(color: Colors.red),
        // focusedBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
        //     borderSide: BorderSide(color: Colors.blue)),
        // enabledBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(12.0)),
        //     borderSide: BorderSide(color: Colors.black38))
        );
  }
}
