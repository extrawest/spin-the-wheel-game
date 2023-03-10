import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/models/prize_type.dart';
import 'package:spin_wheel_game/theme.dart';
import 'package:spin_wheel_game/widgets/gradient_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

const okButtonKey = 'OkButton';

class PrizeDialog extends StatefulWidget {
  final Prize prize;
  final bool isJackpot;

  const PrizeDialog({required this.prize, this.isJackpot = false, Key? key}) : super(key: key);

  @override
  State<PrizeDialog> createState() => _PrizeDialogState();
}

class _PrizeDialogState extends State<PrizeDialog> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 650));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
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
              widget.isJackpot ? widget.prize.prizeType.prizeToString() : widget.prize.description,
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
            MouseRegion(
              cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
              onHover: (event) => setState(() => _isHovered = true),
              onExit: (event) => setState(() => _isHovered = false),
              child: ZoomTapAnimation(
                key: const ValueKey(okButtonKey),
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  okButton,
                  width: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
