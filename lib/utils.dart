import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/models/prize.dart';

final Map<int, Prize> prizes = {
  0: Prize(asset: heart, multiplier: 1, name: 'live', lottie: LottieType.common),
  1: Prize(asset: crown, multiplier: 1, name: 'jackpot', lottie: LottieType.golden),
  2: Prize(asset: diamond, multiplier: 1, name: 'diamond', lottie: LottieType.coins),
  3: Prize(asset: heart, multiplier: 4, name: 'lives', lottie: LottieType.common),
  4: Prize(asset: flash, multiplier: 4, name: 'powers', lottie: LottieType.common),
  5: Prize(asset: dollar, multiplier: 2, name: 'dollars', lottie: LottieType.coins),
  6: Prize(asset: flash, multiplier: 3, name: 'powers', lottie: LottieType.common),
};
