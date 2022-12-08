import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';

class SpinWheelCubit extends Cubit<SpinWheelState> {

  final Map<int, Prize> prizes = {
    1: Prize(asset: heart, multiplier: 1, name: 'live', lottie: LottieType.common),
    2: Prize(asset: crown, multiplier: 1, name: 'Jackpot', lottie: LottieType.golden),
    3: Prize(asset: diamond, multiplier: 1, name: 'diamond', lottie: LottieType.coins),
    4: Prize(asset: heart, multiplier: 4, name: 'lives', lottie: LottieType.common),
    5: Prize(asset: flash, multiplier: 4, name: 'powers', lottie: LottieType.common),
    6: Prize(asset: dollar, multiplier: 2, name: 'dollars', lottie: LottieType.coins),
    7: Prize(asset: flash, multiplier: 3, name: 'powers', lottie: LottieType.common),
  };

  SpinWheelCubit() : super(const SpinWheelState());

  void setIsSpinning(bool isSpinning) {
    emit(state.copyWith(isSpinning: isSpinning));
  }

  void setPrize(int prizeIndex) {
    emit(state.copyWith(currentPrize: prizes[prizeIndex]));
  }

  double generateRandomVelocity() => (Random().nextDouble() * 3000) + 2000;

  double generateRandomAngle() => Random().nextDouble() * pi * 2;
}