import 'dart:async';

import 'package:sky/zeref/zeref_base.dart';

class Zeref<T> implements ZerefBase<T> {
  T value;
  Zeref(this.value);
  final StreamController<T> controller = StreamController<T>();
  StreamSink<T> get valueSink => controller.sink;
  Stream<T> get valueStream => controller.stream;
  @override
  void emit(T value) {
    valueSink.add(value);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // valueSink.addError(error, stackTrace);
    throw UnimplementedError();
  }

  @override
  void dispose() {
    controller.close();
  }

  @override
  void addStream(Stream<T> stream) {
    controller.addStream(stream);
  }
}
