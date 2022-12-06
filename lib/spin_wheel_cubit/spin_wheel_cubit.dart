import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_wheel_game/spin_wheel_cubit/spin_wheel_state.dart';

class SpinWheelCubit extends Cubit<SpinWheelState> {
  SpinWheelCubit() : super(const SpinWheelState());

  void setIsSpinning(bool isSpinning) {
    emit(state.copyWith(isSpinning: isSpinning));
  }
}