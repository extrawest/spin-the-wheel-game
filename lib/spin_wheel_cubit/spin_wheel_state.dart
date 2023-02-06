import 'package:equatable/equatable.dart';
import 'package:spin_wheel_game/models/prize.dart';

class SpinWheelState extends Equatable {
  final bool isSpinning;
  final Prize? currentPrize;
  final int rotationCount;

  const SpinWheelState({
    this.currentPrize,
    this.isSpinning = false,
    this.rotationCount = 10,
  });

  SpinWheelState copyWith({
    bool? isSpinning,
    Prize? currentPrize,
    int? rotationCount,
  }) {
    return SpinWheelState(
      isSpinning: isSpinning ?? this.isSpinning,
      currentPrize: currentPrize ?? this.currentPrize,
      rotationCount: rotationCount ?? this.rotationCount,
    );
  }

  @override
  List<Object?> get props => [
        isSpinning,
        currentPrize,
        rotationCount,
      ];
}
