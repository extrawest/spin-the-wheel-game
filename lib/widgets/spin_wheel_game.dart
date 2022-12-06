import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(fortuneWheelTitle),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: SpinningWheel(
              Image.asset(spinningWheel, width: 500),
              width: 300,
              height: 300,
              dividers: 7,
              canInteractWhileSpinning: false,
              secondaryImage: Image.asset(spinningPointer),
              secondaryImageHeight: 50,
              secondaryImageWidth: 50,
              secondaryImageTop: 0,
            ),
          ),
          const SizedBox(height: 24),
          const SpinButton(),
        ],
      ),
    );
  }
}
