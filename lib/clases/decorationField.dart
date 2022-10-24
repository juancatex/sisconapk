import 'package:flutter/material.dart';

class ThemaField {
  // ignore: non_constant_identifier_names
  InputDecoration FieldDecoration(String nombre) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      labelText: nombre,
      fillColor: Colors.grey[100],
      filled: true,
      labelStyle: const TextStyle(fontSize: 19),
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
