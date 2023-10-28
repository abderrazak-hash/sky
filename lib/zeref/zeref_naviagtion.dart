import 'package:flutter/material.dart';
import 'package:sky/main.dart';
import 'package:sky/zeref/zeref.dart';

class NavigationZeref extends Zeref<void> {
  NavigationZeref() : super(null);

  void navigateTo(BuildContext context, String routeName) {
    dispose();
    context.pushNamed(routeName);
  }
}
