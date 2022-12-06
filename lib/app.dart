import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_wheel_game/screens/home_screen.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpinWheelCubit>(
      create: (context) => SpinWheelCubit(),
      child: MaterialApp(
        title: 'Spinning Wheel Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}