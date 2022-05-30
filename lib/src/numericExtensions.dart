class NumericExtensions {
  static bool isValid(double d) {
    return !(d.isNaN || d.isInfinite);
  }
}
