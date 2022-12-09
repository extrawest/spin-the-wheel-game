import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/lottie_type.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';
import 'package:spin_wheel_game/theme.dart';
import 'package:spin_wheel_game/utils.dart';
import 'package:spin_wheel_game/widgets/fortune_item.dart';
import 'package:spin_wheel_game/widgets/prize_dialog.dart';
import 'package:spin_wheel_game/widgets/spin_button.dart';

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

  final StreamController<int> _fortuneWheelNotifier = StreamController<int>();

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
    _fortuneWheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<StreamController<int>>(
      create: (context) => _fortuneWheelNotifier,
      builder: (context, child) => Column(
        children: [
          BlocConsumer<SpinWheelCubit, SpinWheelState>(
            listenWhen: (prev, curr) => prev.isSpinning != curr.isSpinning,
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
                    FortuneWheel(
                      selected: context.read<StreamController<int>>().stream,
                      rotationCount: state.rotationCount,
                      indicators: const [],
                      items: List.generate(
                        prizes.length,
                        (index) => FortuneItem(
                          child: CustomFortuneItem(prize: prizes[index]!),
                          style: FortuneItemStyle(
                            color: index % 2 == 0 ? orange2 : orange1,
                            borderColor: darkOrange,
                          ),
                        ),
                      ),
                      onAnimationEnd: () {
                        context.read<SpinWheelCubit>().setIsSpinning(false);
                        context.read<SpinWheelCubit>().updateRotationCount();
                      },
                    ),
                    Image.asset(wheelBorder),
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
    if (state.isSpinning == false) {
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
                isJackpot: state.currentPrize!.prizeType == 'jackpot',
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
              width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width,
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
