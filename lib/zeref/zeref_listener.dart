import 'package:flutter/material.dart';
import 'package:sky/main.dart';
import 'package:sky/zeref/zeref.dart';
import 'package:sky/zeref/zeref_builder.dart';
import 'package:sky/zeref/zeref_provider.dart';

class ZerefListener<T extends Zeref> extends StatelessWidget {
  final void Function(BuildContext context, T value) listener;
  final Widget child;
  const ZerefListener({Key? key, required this.listener, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    T value = ZerefProvider.of<T>(context);
    return ZerefBuilder<T>(
      builder: (context, value) {
        listener(context, value);
        return child;
      },
    );
  }
}
