enum PrizeType { heart, energy, diamond, dollar, jackpot }

extension PrizeTypeExt on PrizeType {
  bool get isHeart => this == PrizeType.heart;
  bool get isEnergy => this == PrizeType.energy;
  bool get isDiamond => this == PrizeType.diamond;
  bool get isDollar => this == PrizeType.dollar;
  bool get isJackpot => this == PrizeType.jackpot;
}