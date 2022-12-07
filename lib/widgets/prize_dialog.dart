import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/theme.dart';
import 'package:spin_wheel_game/widgets/gradient_text.dart';

class PrizeDialog extends StatefulWidget {
  final Prize prize;
  final bool isJackpot;

  const PrizeDialog({required this.prize, this.isJackpot = false, Key? key}) : super(key: key);

  @override
  State<PrizeDialog> createState() => _PrizeDialogState();
}

class _PrizeDialogState extends State<PrizeDialog> {
  bool _isOkButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width,
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
          if (widget.isJackpot) Image.asset(jackPot) else Image.asset(congratsText),
          const SizedBox(height: 16),
          Stack(
            children: [
              Image.asset(widget.prize.asset, height: 70),
              if (!widget.isJackpot)
                Positioned(
                  top: 20,
                  left: 35,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(star),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'x${widget.prize.multiplier}',
                        style: TextStyles.bodyReg16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          GradientText(
            widget.isJackpot ? widget.prize.name : widget.prize.description,
            style: TextStyles.bodyReg20,
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
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
