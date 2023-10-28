abstract class ZerefBase<T> {
  void dispose() {}
  void emit(T value) {}
  void addError(Object error, [StackTrace? stackTrace]) {}
  void addStream(Stream<T> stream) {}
}
