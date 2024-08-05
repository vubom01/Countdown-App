import 'package:equatable/equatable.dart';

abstract class AppState<T> extends Equatable {
  final T data;

  const AppState(this.data);
}
