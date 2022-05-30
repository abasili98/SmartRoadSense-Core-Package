//import da spostare nel file principale
import 'dart:math';

class HammingWindow {
  static List<double> generate(int size) {
    double ch = 2 * pi / (size - 1);

    List<double> window = new List<double>.filled(size, 0);
    for (int i = 0; i < size; ++i) {
      window[i] = (0.54 - 0.46 * cos(ch * i /*.toDouble()*/));
    }

    return window;
  }
}
