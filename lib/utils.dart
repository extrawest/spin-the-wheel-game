import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/models/prize_type.dart';

final Map<int, Prize> prizes = {
  0: Prize(asset: heart, multiplier: 1, prizeType: PrizeType.heart, lottie: LottieType.common),
  1: Prize(asset: darkCrown, multiplier: 1, prizeType: PrizeType.jackpot, lottie: LottieType.golden),
  2: Prize(asset: diamond, multiplier: 1, prizeType: PrizeType.diamond, lottie: LottieType.coins),
  3: Prize(asset: heart, multiplier: 4, prizeType: PrizeType.heart, lottie: LottieType.common),
  4: Prize(asset: flash, multiplier: 4, prizeType: PrizeType.energy, lottie: LottieType.common),
  5: Prize(asset: dollar, multiplier: 2, prizeType: PrizeType.dollar, lottie: LottieType.coins),
  6: Prize(asset: flash, multiplier: 3, prizeType: PrizeType.energy, lottie: LottieType.common),
};
