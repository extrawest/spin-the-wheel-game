import 'package:equatable/equatable.dart';
import 'package:spin_wheel_game/models/prize.dart';

class SpinWheelState extends Equatable {
  final bool isSpinning;
  final Prize? currentPrize;

  const SpinWheelState({
    this.currentPrize,
    this.isSpinning = false,
  });

  SpinWheelState copyWith({
    bool? isSpinning,
    Prize? currentPrize,
  }) {
    return SpinWheelState(
      isSpinning: isSpinning ?? this.isSpinning,
      currentPrize: currentPrize ?? this.currentPrize,
    );
  }

  @override
  List<Object?> get props => [
        isSpinning,
        currentPrize,
      ];
}
