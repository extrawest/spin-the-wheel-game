import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/models/prize_type.dart';

class Prize {
  final String asset;
  final int multiplier;
  final PrizeType prizeType;
  final LottieType lottie;
  late final String description;

  Prize({
    required this.asset,
    required this.multiplier,
    required this.prizeType,
    required this.lottie,
  }) {
    description = "You've got $multiplier more ${prizeType.prizeToString()}";
  }
}
