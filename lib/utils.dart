import 'dart:math';

double generateRandomVelocity() => (Random().nextDouble() * 3000) + 2000;

double generateRandomAngle() => Random().nextDouble() * pi * 2;