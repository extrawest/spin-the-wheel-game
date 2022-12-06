import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';
import 'package:spin_wheel_game/utils.dart';

class SpinButton extends StatefulWidget {
  const SpinButton({Key? key}) : super(key: key);

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpinWheelCubit, SpinWheelState>(
      builder: (context, state) => GestureDetector(
        onTap: state.isSpinning
            ? null
            : () {
                context.read<StreamController<double>>().sink.add(generateRandomVelocity());
                context.read<SpinWheelCubit>().setIsSpinning(true);
              },
        child: SizedBox(
          height: 100,
          child: Image.asset(
            state.isSpinning ? spinButtonPressed : spinButton,
          ),
        ),
      ),
    );
  }
}
