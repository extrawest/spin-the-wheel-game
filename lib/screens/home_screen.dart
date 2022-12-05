import 'package:flutter/material.dart';
import 'package:spin_wheel_game/widgets/spin_wheel_game.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinWheelGame(),
    );
  }
}
