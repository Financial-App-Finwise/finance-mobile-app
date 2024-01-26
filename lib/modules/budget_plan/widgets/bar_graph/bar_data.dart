class BarData {
  final double lastSixthMonth;
  final double lastFifthMonth;
  final double lastFourthMonth;
  final double lastThirdMonth;
  final double lastSecondMonth;
  final double lastFirstMonth;

  BarData({
    required this.lastSixthMonth,
    required this.lastFifthMonth,
    required this.lastFourthMonth,
    required this.lastThirdMonth,
    required this.lastSecondMonth,
    required this.lastFirstMonth,
  });

  List<IndividualBar> barData = [];

  void initializedBarData() {
    barData = [
      IndividualBar(x: 0, y: lastSixthMonth),
      IndividualBar(x: 1, y: lastFifthMonth),
      IndividualBar(x: 2, y: lastFourthMonth),
      IndividualBar(x: 3, y: lastThirdMonth),
      IndividualBar(x: 4, y: lastSecondMonth),
      IndividualBar(x: 5, y: lastFirstMonth),
    ];
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}
