class Prize {
  final String asset;
  final int multiplier;
  final String name;
  late final String description;

  Prize({
    required this.asset,
    required this.multiplier,
    required this.name,
  }) {
    description = "You've got $multiplier more $name";
  }
}
