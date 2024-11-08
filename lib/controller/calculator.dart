import 'package:calculator_bo6/model/values_model.dart';
import 'package:flutter/foundation.dart';

class Calculator {
  ValuesModel vM = ValuesModel(
    x: 0,
    y: 0,
    z: 0,
    res1: 0,
    res2: 0,
    res3: 0,
  );

  void calculateAll() {
    debugPrint("Init res1 $vM.res1 | res2 $vM.res2 | res3 $vM.res3");
    vM.res1 = calculateFirstFormula();
    vM.res2 = calculateSecondFormula();
    vM.res3 = calculateThirdFormula();
    debugPrint("final res1 $vM.res1 | res2 $vM.res2 | res3 $vM.res3");
    // return [x!, y!, z!];
  }

  int calculateFirstFormula() => vM.x != null ? 2 * vM.x! + 11 : 0;
  int calculateSecondFormula() => (vM.z != null && vM.y != null) ? (2 * vM.z! + vM.y!) - 5 : 0;
  int calculateThirdFormula() => (vM.y != null && vM.z != null && vM.x != null) ? ((vM.y! + vM.z!) - vM.x!).abs() : 0;

  void clearValues() {
    debugPrint("Init X $vM.x | Y $vM.y | Z $vM.z");

    vM.x = 0;
    vM.z = 0;
    vM.y = 0;

    vM.res1 = 0;
    vM.res2 = 0;
    vM.res3 = 0;
    debugPrint("final X $vM.x | Y $vM.y | Z $vM.z");
  }
}
