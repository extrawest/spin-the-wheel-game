import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/theme.dart';
import 'package:spin_wheel_game/widgets/gradient_text.dart';

class PrizeDialog extends StatefulWidget {
  final Prize prize;

  const PrizeDialog({required this.prize, Key? key}) : super(key: key);

  @override
  State<PrizeDialog> createState() => _PrizeDialogState();
}

class _PrizeDialogState extends State<PrizeDialog> {
  bool _isOkButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border.all(color: orange2, width: 15.0),
        borderRadius: BorderRadius.circular(45),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            lightOrange,
            orange1,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(congratsText),
          const SizedBox(height: 16),
          Stack(
            children: [
              Image.asset(widget.prize.asset, height: 70),
              Positioned(top: 20, left: 35, child: Image.asset(star, width: 50)),
            ],
          ),
          const SizedBox(height: 8),
          GradientText(
            widget.prize.description,
            style: const TextStyle(
              fontFamily: 'Gluten',
              fontSize: 20,
              color: lightOrange,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                orange3,
                orange4,
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onPanStart: (details) => setState(() => _isOkButtonPressed = true),
            onPanEnd: (details) {
              setState(() => _isOkButtonPressed = false);
              Navigator.pop(context);
            },
            child: Image.asset(
              _isOkButtonPressed ? okButtonPressed : okButton,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
