import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SpinButton extends StatefulWidget {
  const SpinButton({Key? key}) : super(key: key);

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpinWheelCubit, SpinWheelState>(
      builder: (context, state) => ZoomTapAnimation(
        onTap: state.isSpinning
            ? null
            : () {
                context.read<StreamController<double>>().sink.add(context.read<SpinWheelCubit>().generateRandomVelocity());
                context.read<SpinWheelCubit>().setIsSpinning(true);
              },
        child: MouseRegion(
          cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onHover: (event) => setState(() => _isHovered = true),
          onExit: (event) => setState(() => _isHovered = false),
          child: Image.asset(
            state.isSpinning ? spinButtonPressed : spinButton,
          ),
        ),
      ),
    );
  }
}
