import 'dart:math';

import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/prize.dart';

double generateRandomVelocity() => (Random().nextDouble() * 3000) + 2000;

double generateRandomAngle() => Random().nextDouble() * pi * 2;

Map<int, Prize> prizes = {
  1: Prize(asset: heart, multiplier: 1, name: 'live'),
  2: Prize(asset: crown, multiplier: 1, name: 'Jackpot'),
  3: Prize(asset: diamond, multiplier: 1, name: 'diamond'),
  4: Prize(asset: heart, multiplier: 4, name: 'lives'),
  5: Prize(asset: flash, multiplier: 4, name: 'powers'),
  6: Prize(asset: dollar, multiplier: 2, name: 'dollars'),
  7: Prize(asset: flash, multiplier: 3, name: 'powers'),
};