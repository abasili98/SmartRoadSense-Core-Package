import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
import 'dart:math';

/// <summary>
/// Numeric value with statistical information.
/// </summary>
class StatisticalValue /*implements Comparable*/ {
  late double _avarage, _variance, _standardDeviation;

  final StatisticalValue zero =
      StatisticalValue.StatisticalValueDouble(0.0, 0.0);
  
  final StatisticalValue perfectOne =
      StatisticalValue.StatisticalValueDouble(1.0, 0.0);

  StatisticalValue.StatisticalValueDouble(double avarage, double variance) {
    this._avarage = avarage;
    this._variance = variance;
    this._standardDeviation = sqrt(variance);
  }

  StatisticalValue.StatisticalIterable(Iterable sequence) {
    if (sequence is List<double>) {
      /* //int i = 0;
      double sum = 0;
      sequence.forEach((element) {
        sum += element;
        //i++;
      });

      this._avarage = sum / sequence.length;
*/
      this._avarage = MathematicalExtensions.avarage(sequence);

      this._variance = StatisticalExtensions.varianceMean(sequence, _avarage);

      this._standardDeviation - sqrt(_variance);
    } else {
      /*List<double> list = List<double>.from(sequence);
      StatisticalValue.StatisticalIterable(list);*/
      StatisticalValue.StatisticalIterable(List<double>.from(sequence));
    }
  }

  double get avarage => this._avarage;
  double get variance => this._variance;
  double get standardDeviation => this._standardDeviation;

  int get getHashCode => this._avarage.hashCode;

  bool equals(StatisticalValue other) {
    if (this._avarage != other.avarage || this._variance != other.variance)
      return false;

    return true;
  }

/*
  String toString() {
    return String;
  }
*/

  int compareTo(StatisticalValue other) {
    return this._avarage.compareTo(other.avarage);
  }
} //FINE CLASSE
