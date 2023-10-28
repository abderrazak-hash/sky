import 'package:flutter/material.dart';
import 'package:sky/main.dart';
import 'package:sky/zeref/zeref.dart';

class ZerefBuilder<T extends Zeref> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;
  const ZerefBuilder({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    T value = context.get<T>();
    Stream? stream = value.valueStream;

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return builder(context, value);
      },
    );
  }
}
