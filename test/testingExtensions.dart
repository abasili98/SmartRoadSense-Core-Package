import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';

enum Meto {
  computeAutoCorrelation,
  estimateAutoRegressiveModel,
  computeLevinsonDurbin
}

class TestingExtension {
  static List<double> executeNumericMethod(
      Engine e, Meto methodName, List<double> input) {
    var implOutput;

    switch (methodName) {
      case Meto.computeAutoCorrelation:
        implOutput = e.comp(input);
        break;
      case Meto.estimateAutoRegressiveModel:
        implOutput = e.estimate(input);
        break;
      case Meto.computeLevinsonDurbin:
        implOutput = e.levinson(input);
        break;
      default:
        throw new Exception("Scelta non valida");
    }

    return implOutput;
  }
}
