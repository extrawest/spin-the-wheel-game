import 'package:equatable/equatable.dart';

class SpinWheelState extends Equatable {
  final bool isSpinning;

  const SpinWheelState({
    this.isSpinning = false,
  });

  SpinWheelState copyWith({bool? isSpinning}) {
    return SpinWheelState(
      isSpinning: isSpinning ?? this.isSpinning,
    );
  }

  @override
  List<Object?> get props => [
        isSpinning,
      ];
}
