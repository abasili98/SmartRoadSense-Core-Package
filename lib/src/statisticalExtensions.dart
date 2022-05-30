import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';

class StatisticalExtensions {
  /// <summary>
  /// Computes the variance of a double sequence.
  /// </summary>
  static double varianceMean(Iterable<double> sequence, double mean) {
    //Non puó mai essere null -> inutile
    //if (sequence == null) throw new Exception("NULL Argument");

    double acc = 0;
    int count = 0;

    sequence.forEach((element) {
      var diff = (element - mean);
      acc += diff * diff;
      ++count;
    });

    if (count <= 0) return 0.0;

    return (acc / count);
  }

  /// <summary>
  /// Computes the variance of a double sequence.
  /// </summary>
  static double variance(Iterable<double> sequence) {
    double sum = 0.0;
    int i = 0;
    sequence.forEach((element) {
      sum += element;
      i++;
    });

    return varianceMean(sequence, sum / i);
  }

  /// <summary>
  /// Computes the basic statistical info about a numeric sequence.
  /// </summary>
  static StatisticalValue computeStats(Iterable sequence) {
    return new StatisticalValue.StatisticalIterable(sequence);
  }

  /// <summary>
  /// Detrends a numeric sequence.
  /// </summary>
  static Iterable<dynamic> detrend(Iterable<double> sequence) sync* {
    var mean = MathematicalExtensions.avarage(sequence);
    int i;
    int finish = sequence.length;
    List list = sequence.toList();
    for (i = 0; i < finish; i++) yield (list[i] - mean);
  }

  /// <summary>
  /// Computes the autocorrelation of a numeric sequence.
  /// </summary>
  static List<double> autoCorrelation(List<double> sequence, int order) {
    if (order < 0) throw new Exception("Argument out of Range");

    //List<double> ret = new List.filled(sequence.length + order, 0);
    List<double> ret = new List.empty(growable: true);

    for (int i = 0; i < sequence.length + order; ++i) {
      //Operand A is preprended by zeros (# = order)
      double a = 0;
      if (i - order >= 0) a = sequence[i - order];

      //Operand B is followed by equal number of zeros
      double b = 0;
      if (i < sequence.length) b = sequence[i];

      //ret[i] = a * b;
      ret.add(a * b);
    }
    return ret;
  }
} //FINE CLASSE
