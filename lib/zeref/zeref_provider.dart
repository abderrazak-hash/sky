import 'package:flutter/material.dart';
import 'package:sky/zeref/zeref_base.dart';

class ZerefProvider<T extends ZerefBase> extends StatefulWidget {
  final T value;
  final Widget? child;
  const ZerefProvider({Key? key, required this.value, this.child})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ZerefProviderState();
  }

  static T of<T extends ZerefBase>(BuildContext context) {
    ZerefProvider<T>? provider =
        context.findAncestorWidgetOfExactType<ZerefProvider<T>>();
    return provider!.value;
  }
}

class _ZerefProviderState extends State<ZerefProvider> {
  @override
  Widget build(BuildContext context) {
    super.dispose();
    return widget.child ?? const SizedBox.shrink();
  }

  @override
  void dispose() {
    widget.value.dispose();
    widget.createState();
    setState(() {});

    super.dispose();
  }
}
