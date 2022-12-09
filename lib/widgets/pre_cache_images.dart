import 'package:flutter/material.dart';
import 'package:spin_wheel_game/assets.dart';
import 'package:spin_wheel_game/screens/home_screen.dart';

class PreCacheImages extends StatefulWidget {
  const PreCacheImages({Key? key}) : super(key: key);

  @override
  State<PreCacheImages> createState() => _PreCacheImagesState();
}

class _PreCacheImagesState extends State<PreCacheImages> {
  late final List<Image> _allImages;

  @override
  void initState() {
    _allImages = [
      Image.asset(backgroundImage),
      Image.asset(crown),
      Image.asset(star),
      Image.asset(heart),
      Image.asset(flash),
      Image.asset(jackPot),
      Image.asset(okButton),
      Image.asset(spinButton),
      Image.asset(spinButtonPressed),
      Image.asset(spinningWheel),
      Image.asset(fortuneWheelTitle),
      Image.asset(spinningPointer),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    for (final asset in _allImages) {
      precacheImage(asset.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
