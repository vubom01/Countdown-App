import 'abstract_state.dart';

class WithDrawTopupState extends AppState<int> {
  final int topupId;
  final int amount;

  const WithDrawTopupState({
    required this.amount,
    required this.topupId,
  }) : super(amount);

  @override
  List<Object?> get props => [topupId, amount];
}
