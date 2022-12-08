enum LottieType { common, coins, golden }

extension LottieTypeExt on LottieType {
  bool get isCommon => this == LottieType.common;
  bool get isCoins => this == LottieType.coins;
  bool get isGolden => this == LottieType.golden;
}