//import 'dart:io';
import 'package:collection/collection.dart';
//import 'package:dartz/dartz_unsafe.dart';

//import '../SmartRoadSense-Core-Package.dart';
import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';

//import 'package:dartz/dartz.dart';
//import 'package:queries/queries.dart';
//import 'package:queries/collections.dart';

/// <summary>
/// High-performance mathemtical operations on raw data buffers.
/// </summary>
class MathematicalExtensions {
  /// <summary>
  /// In-place detrending of an array of values.
  /// </summary>
  static void detrendOne(List<double> data) {
    double sum = 0;
    //double i = 0;
    data.forEach((element) {
      sum = sum + element;
      //i++;
    });
    
    detrendTwo(data, sum / data.length);

    //detrendTwo(data, data.average.toDouble());
  }

  /// <summary>
  /// In-place detrending of an array of values, given a pre-computed mean value.
  /// </summary>
  static void detrendTwo(List<double> data, double mean) {
    int len = data.length;
    for (int i = 0; i < len; ++i) {
      data[i] = data[i] - mean;
    }
  }

  /// <summary>
  /// In-place multiplication of an array times another array of factors.
  /// </summary>
  static void multiply1(List<double> data, List<double>? factors) {
    if (data.length != factors!.length)
      throw new Exception("Arrays must be of same length");

    int len = data.length;
    for (int i = 0; i < len; ++i) {
      data[i] = data[i] * factors[i];
    }
  }

  /// <summary>
  /// In-place multiplication of an array times a scalar factor.
  /// </summary>
  static void multiply2(List<double> data, double factor) {
    int len = data.length;
    for (int i = 0; i < len; ++i) {
      data[i] = data[i] * factor;
    }
  }

  static double matrixProductSum(List<dynamic> a, List<dynamic> b) {
    /*
    //SEMPRE FALSA
    if (a == null || b == null)
      throw new Exception("NULL Argument");
    */
    if (a.length != b.length)
      throw new Exception("Operand A and B have different length");
    if (a.length < 0) throw new Exception("Operand lengths cannot be 0");

    double ret = 0;
    int len = a.length;
    for (int i = 0; i < len; ++i) {
      ret += (a[i] * b[i]);
    }

    return ret;
  }

  /// <summary>
  /// In-place sign flip.
  /// </summary>
  static void flipSign(List<double> sequence) {
    int len = sequence.length;
    for (int i = 0; i < len; ++i) sequence[i] = -sequence[i];
  }

  static double avarage(Iterable iterable) {
    num sum = 0;
    int i = 0;
    iterable.forEach((element) {
      sum += element;
      i++;
    });

    return sum / i;
  }
} //FINE CLASSE
