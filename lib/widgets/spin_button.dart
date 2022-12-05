import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';

class SpinButton extends StatefulWidget {
  const SpinButton({Key? key}) : super(key: key);

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _isButtonPressed = true;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isButtonPressed = false;
        });
      },
      child: SizedBox(
        height: 100,
        child: Image.asset(
          _isButtonPressed ? spinButtonPressed : spinButton,
        ),
      ),
    );
  }
}
