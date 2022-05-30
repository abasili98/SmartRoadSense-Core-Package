//FINITO
//import 'package:test/expect.dart';

class CheckExtensions {
  static assertEquals(List/*<double>*/ a, List/*<double>*/ b) {
    if (a.length != b.length)
      throw new ArgumentError("Lists have different length");

    for (int i = 0; i < a.length; ++i)
      if (a[i] != b[i]) {
        var ai = a[i];
        var bi = b[i];
        throw new ArgumentError("Element $i is different ($ai != $bi");
      }
  } //FINE EQUALS

  static assertError(List<double> a, List<double> b) {
    if (a.length != b.length)
      throw new ArgumentError("Lists have different length");

    double maxError = -double.maxFinite;

    for (int i = 0; i < a.length; ++i) {
      double error = (a[i] - b[i]).abs();
      if (error > maxError) maxError = error;

      if (error >= 0.000000001) 
        //print("Element $i -> error: $error");
        throw new Exception("Element $i has error $error");

      //per testing giusto sopra
      //if (error < 0.000000001) print("$i - $error");

    }

    print("Max error: $maxError");
  }
}//FINE CLASSE
