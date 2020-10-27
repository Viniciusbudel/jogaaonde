import 'dart:async';

class SimpleBloc<T>{
  final controller = StreamController<T>();

  Stream<T> get stream => controller.stream;

  void add(T){
    controller.add(T);
  }
  void addError(T){
    controller.addError(T);
  }

  void dispose() {
    controller.close();
  }
}