import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';

class SpinWheelGame extends StatefulWidget {
  const SpinWheelGame({Key? key}) : super(key: key);

  @override
  State<SpinWheelGame> createState() => _SpinWheelGameState();
}

class _SpinWheelGameState extends State<SpinWheelGame> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(fortuneWheelTitle),
          const SizedBox(height: 24),
          const SpinButton(),
        ],
      ),
    );
  }
}
