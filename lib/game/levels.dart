class GameLevels {
  static const List<List<int>> level1 = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 2, 0, 0, 0, 1, 0, 0, 3, 0, 0, 1],
    [1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1],
    [1, 0, 0, 3, 0, 0, 0, 0, 0, 3, 4, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];

  static const List<List<int>> level2 = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 2, 0, 0, 0, 1, 3, 0, 0, 1, 0, 0, 3, 1],
    [1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1],
    [1, 3, 1, 1, 0, 1, 0, 0, 3, 1, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1],
    [1, 0, 1, 1, 0, 3, 0, 0, 0, 0, 0, 1, 4, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];

  static const List<List<int>> level3 = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 2, 0, 0, 1, 3, 0, 0, 3, 0, 1, 3, 0, 0, 1],
    [1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1],
    [1, 3, 0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 1, 3, 1],
    [1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1],
    [1, 3, 0, 0, 3, 0, 0, 3, 0, 0, 3, 0, 0, 4, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
  ];

  static const Map<int, String> levelNames = {
    1: "SECTOR 1: Nightcity",
    2: "SECTOR 2: Centro de Abstergo",
    3: "SECTOR 3: La ultima batalla",
  };

  static String getName(int index) => levelNames[index] ?? "SECTOR DESCONOCIDO";

  static List<List<int>> getLevel(int index) {
    if (index == 2) return level2;
    if (index >= 3) return level3;
    return level1;
  }
}
