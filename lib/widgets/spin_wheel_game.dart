import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:provider/provider.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/utils.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';

const _horizontalPaddingValue = 24.0;

class SpinWheelGame extends StatefulWidget {
  const SpinWheelGame({Key? key}) : super(key: key);

  @override
  State<SpinWheelGame> createState() => _SpinWheelGameState();
}

class _SpinWheelGameState extends State<SpinWheelGame> {
  final StreamController _dividerController = StreamController<int>();
  final StreamController<double> _wheelNotifier = StreamController<double>();

  @override
  void dispose() {
    _wheelNotifier.close();
    _dividerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => _wheelNotifier,
      child: const _SpinWheelGameContent(),
    );
  }
}

class _SpinWheelGameContent extends StatelessWidget {
  const _SpinWheelGameContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPaddingValue),
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
              Image.asset(spinningWheelFilled),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (_horizontalPaddingValue * 2),
              dividers: 7,
              canInteractWhileSpinning: false,
              secondaryImage: Image.asset(spinningPointer),
              secondaryImageHeight: 50,
              secondaryImageWidth: 50,
              secondaryImageTop: 0,
              secondaryImageLeft: MediaQuery.of(context).size.width / 2 - _horizontalPaddingValue * 2,
              shouldStartOrStop: context.read<StreamController<double>>().stream,
              spinResistance: 0.1,
              initialSpinAngle: generateRandomAngle(),
              onEnd: (value) {
                context.read<SpinWheelCubit>().setIsSpinning(false);
              },
            ),
          ),
          const SizedBox(height: 24),
          const SpinButton(),
        ],
      ),
    );
  }
}
