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

const _horizontalPaddingValue = 24.0;

class SpinWheelGame extends StatefulWidget {
  const SpinWheelGame({Key? key}) : super(key: key);

  @override
  State<SpinWheelGame> createState() => _SpinWheelGameState();
}

class _SpinWheelGameState extends State<SpinWheelGame> {
  final StreamController<double> _wheelNotifier = StreamController<double>();

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => _wheelNotifier),
      ],
      child: const _SpinWheelGameContent(),
    );
  }
}

class _SpinWheelGameContent extends StatefulWidget {
  const _SpinWheelGameContent({Key? key}) : super(key: key);

  @override
  State<_SpinWheelGameContent> createState() => _SpinWheelGameContentState();
}

class _SpinWheelGameContentState extends State<_SpinWheelGameContent> with TickerProviderStateMixin {
  late final AnimationController _defaultLottieController;

  late final AnimationController _coinsLottieController;

  late final AnimationController _goldenConfettiLottieController;

  @override
  void initState() {
    _defaultLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);
    _coinsLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);
    _goldenConfettiLottieController = AnimationController(vsync: this)..duration = const Duration(seconds: 3);

    super.initState();
  }

  @override
  void dispose() {
    _defaultLottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPaddingValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(fortuneWheelTitle),
              const SizedBox(height: 24),
              AbsorbPointer(
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
                  onEnd: (prizeIndex) {
                    context.read<SpinWheelCubit>().setIsSpinning(false);
                    _showPrizeDialog(context, prizeIndex);
                    _playLottie(prizeIndex);
                  },
                ),
              ),
              const SizedBox(height: 24),
              const SpinButton(),
            ],
          ),
        ),
      ],
    );
  }

  void _showPrizeDialog(BuildContext context, int prizeIndex) {
    showDialog(
      context: context,
      builder: (_) => Stack(
        children: [
          Center(
            child: PrizeDialog(
              prize: prizes[prizeIndex]!,
              isJackpot: prizeIndex == 2,
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
    if(prizeIndex == 2) {
      _goldenConfettiLottieController.forward().then((value) => _goldenConfettiLottieController.reset());
    } else if(prizeIndex == 3 || prizeIndex == 6) {
      _coinsLottieController.forward().then((value) => _coinsLottieController.reset());
    } else {
      _defaultLottieController.forward().then((value) => _defaultLottieController.reset());
    }
  }
}
