import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/models/prize.dart';
import 'package:spin_wheel_game/models/prize_type.dart';
import 'package:spin_wheel_game/theme.dart';

class CustomFortuneItem extends StatelessWidget {
  final Prize prize;

  const CustomFortuneItem({required this.prize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: prize.prizeType.isJackpot
          ? const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(jackpotBg),
                fit: BoxFit.cover,
              ),
            )
          : const BoxDecoration(
              gradient: orangeGradientLight,
            ),
      child: Transform.rotate(
        angle: pi / 2,
        child: SizedBox(
          height: 90,
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(prize.prizeType.isJackpot)
                Image.asset(jackPot, width: 100),
              Stack(
                children: [
                  Center(child: Image.asset(prize.asset, height: 80)),
                  if (!prize.prizeType.isJackpot)
                    Positioned.fill(
                      top: 20,
                      left: 35,
                      child: Align(
                        alignment: Alignment.center,
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
                              'x${prize.multiplier}',
                              style: TextStyles.bodyReg16,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
