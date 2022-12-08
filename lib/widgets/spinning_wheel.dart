import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/utils.dart';
import 'package:spin_wheel_game/widgets/prize_dialog.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';
import 'package:spin_wheel_game/widgets/spin_wheel_game.dart';

class CustomSpinningWheel extends StatefulWidget {
  const CustomSpinningWheel({Key? key}) : super(key: key);

  @override
  State<CustomSpinningWheel> createState() => _CustomSpinningWheelState();
}

class _CustomSpinningWheelState extends State<CustomSpinningWheel> with TickerProviderStateMixin{
  late final AnimationController _defaultLottieController;

  late final AnimationController _coinsLottieController;

  late final AnimationController _goldenConfettiLottieController;

  final StreamController<double> _wheelNotifier = StreamController<double>();


  @override
  void initState() {
    _defaultLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);
    _coinsLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);
    _goldenConfettiLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);

    super.initState();
  }

  @override
  void dispose() {
    _coinsLottieController.dispose();
    _goldenConfettiLottieController.dispose();
    _defaultLottieController.dispose();
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<StreamController<double>>(
      create: (context) => _wheelNotifier,
      builder: (context, child) => Column(
        children: [
          AbsorbPointer(
            child: Stack(
              children: [
                SpinningWheel(
                  Image.asset(spinningWheelFilled),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - (horizontalPaddingValue * 2),
                  dividers: 7,
                  canInteractWhileSpinning: false,
                  shouldStartOrStop: context.read<StreamController<double>>().stream,
                  spinResistance: 0.1,
                  initialSpinAngle: generateRandomAngle(),
                  onEnd: (prizeIndex) {
                    context.read<SpinWheelCubit>().setIsSpinning(false);
                    _showPrizeDialog(context, prizeIndex);
                    _playLottie(prizeIndex);
                  },
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      spinningPointer,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SpinButton(),
        ],
      ),
    );
  }

  void _showPrizeDialog(BuildContext context, int prizeIndex) {
    showDialog(
      context: context,
      builder: (_) => Stack(
        children: [
          Center(
            child: SizedBox(
              width: 500,
              child: PrizeDialog(
                prize: prizes[prizeIndex]!,
                isJackpot: prizeIndex == 2,
              ),
            ),
          ),
          ..._buildLotties(),
        ],
      ),
    );
  }

  List<Widget> _buildLotties() {
    return [
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: IgnorePointer(
            child: Lottie.asset(
              defaultLottie,
              controller: _defaultLottieController,
              height: 800,
              width: 600,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: IgnorePointer(
            child: Lottie.asset(
              goldenConfettiLottie,
              controller: _coinsLottieController,
              height: 800,
              width: 600,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.topCenter,
          child: IgnorePointer(
            child: Lottie.asset(
              coinsLottie,
              controller: _goldenConfettiLottieController,
              fit: BoxFit.fill,
              height: 800,
            ),
          ),
        ),
      ),
    ];
  }

  void _playLottie(int prizeIndex) {
    if (prizeIndex == 2) {
      _goldenConfettiLottieController.forward().then((value) => _goldenConfettiLottieController.reset());
    } else if (prizeIndex == 3 || prizeIndex == 6) {
      _coinsLottieController.forward().then((value) => _coinsLottieController.reset());
    } else {
      _defaultLottieController.forward().then((value) => _defaultLottieController.reset());
    }
  }
}
