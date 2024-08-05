import 'abstract_state.dart';

class DemoState extends AppState<dynamic> {
  final dynamic dataState;

  const DemoState(this.dataState) : super(dataState);

  @override
  List<Object?> get props => [dataState];
}
