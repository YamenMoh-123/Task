import 'package:flutter/material.dart';



final ButtonStyle mainButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(Colors.blue.shade100),
  foregroundColor: WidgetStateProperty.all(Colors.black),
  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 25, vertical: 5)),
  shape: WidgetStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  )),
);

