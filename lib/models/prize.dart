import 'package:spin_wheel_game/models/lottie_type.dart';

class Prize {
  final String asset;
  final int multiplier;
  final String name;
  final LottieType lottie;
  late final String description;

  Prize({
    required this.asset,
    required this.multiplier,
    required this.name,
    required this.lottie,
  }) {
    description = "You've got $multiplier more $name";
  }
}
