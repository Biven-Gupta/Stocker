import 'package:flutter/material.dart';

class Widgets {
  Widgets._();

  static Widget isLoading({Color? col}) {
    return Center(child: CircularProgressIndicator(color: col ?? Colors.black));
  }
}
