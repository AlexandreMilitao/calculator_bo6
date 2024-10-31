class Calculator {
  int? x;
  int? y;
  int? z;
  Calculator({
    this.x,
    this.y,
    this.z,
  });

  int calculateFirstFormula() => x != null ? 2 * x! + 11 : 0;
  int calculateSecondFormula() => (z != null && y != null) ? (2 * z! + y!) - 5 : 0;
  int calculateThirdFormula() => (y != null && z != null && x != null) ? ((y! + z!) - x!).abs() : 0;
}
