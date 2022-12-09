import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';
import 'package:spin_wheel_game/widgets/prize_dialog.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';
import 'package:spin_wheel_game/widgets/spin_wheel_game.dart';

const _wheelDiameter = 500.0;

class CustomSpinningWheel extends StatefulWidget {
  const CustomSpinningWheel({Key? key}) : super(key: key);

  @override
  State<CustomSpinningWheel> createState() => _CustomSpinningWheelState();
}

class _CustomSpinningWheelState extends State<CustomSpinningWheel> with TickerProviderStateMixin {
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
          BlocConsumer<SpinWheelCubit, SpinWheelState>(
            listenWhen: (prev, curr) => prev.currentPrize != curr.currentPrize,
            listener: _spinListener,
            builder: (context, state) => ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: _wheelDiameter,
                minWidth: _wheelDiameter,
                minHeight: _wheelDiameter,
              ),
              child: AbsorbPointer(
                child: Stack(
                  children: [
                    SpinningWheel(
                      Image.asset(spinningWheelFilled, width: _wheelDiameter, height: _wheelDiameter),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width - (horizontalPaddingValue * 2),
                      dividers: 7,
                      canInteractWhileSpinning: false,
                      shouldStartOrStop: context.read<StreamController<double>>().stream,
                      spinResistance: 0.1,
                      initialSpinAngle: context.read<SpinWheelCubit>().generateRandomAngle(),
                      onEnd: (prizeIndex) {
                        context.read<SpinWheelCubit>().setIsSpinning(false);
                        context.read<SpinWheelCubit>().setPrize(prizeIndex);
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
            ),
          ),
          const SizedBox(height: 24),
          const SpinButton(),
        ],
      ),
    );
  }

  void _spinListener(BuildContext context, SpinWheelState state) {
    if (state.currentPrize != null) {
      _showPrizeDialog(context, state);
      _playLottie(state.currentPrize!.lottie);
    }
  }

  void _showPrizeDialog(BuildContext context, SpinWheelState state) {
    showDialog(
      context: context,
      builder: (_) => Stack(
        children: [
          Center(
            child: SizedBox(
              width: 500,
              child: PrizeDialog(
                prize: state.currentPrize!,
                isJackpot: state.currentPrize!.name == 'jackpot',
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
              height: MediaQuery.of(context).size.height,
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
              height: MediaQuery.of(context).size.height,
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
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    ];
  }

  void _playLottie(LottieType lottie) {
    if (lottie.isGolden) {
      _goldenConfettiLottieController.forward().then((value) => _goldenConfettiLottieController.reset());
    } else if (lottie.isCoins) {
      _coinsLottieController.forward().then((value) => _coinsLottieController.reset());
    } else if (lottie.isCommon) {
      _defaultLottieController.forward().then((value) => _defaultLottieController.reset());
    }
  }
}
