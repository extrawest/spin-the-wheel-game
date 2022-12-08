import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/widgets/spinning_wheel.dart';

const horizontalPaddingValue = 24.0;

class SpinWheelGame extends StatelessWidget {
  const SpinWheelGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingValue),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: Image.asset(fortuneWheelTitle)),
                      const SizedBox(height: 24),
                      Expanded(
                        flex: 8,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ),
                          child: const CustomSpinningWheel(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
