import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/widgets/spinning_wheel.dart';

const horizontalPaddingValue = 16.0;

class SpinWheelGame extends StatelessWidget {
  const SpinWheelGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingValue),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(fortuneWheelTitle),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: const CustomSpinningWheel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
