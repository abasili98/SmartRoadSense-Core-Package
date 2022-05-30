//DA RICONTROLLARE SE BISOGNA METTERE FINAL

//NON FINITA DA RINCONTROLLARE

class EngineSettings {
  static const int defaultWindowSize = 100;
  static const int defaultWindowOverlap = 50;
  static const int defaultModelOrder = 6;
  static const int defaultMovingAverageOrder = 10;

  //dovrebbe essere final??
  late final int windowSize;

  //dovrebbe essere final??
  late final int windowOverlap;

  late final int modelOrder;
  late final int movingAverageOrder;

  //dovrebbe essere final??
  late final bool ignoreEngineErrors;

  EngineSettings(
      {windowSize = defaultWindowSize,
      windowOverlap = defaultWindowOverlap,
      modelOrder = defaultModelOrder,
      movingAverageOrder = defaultMovingAverageOrder,
      ignoreEngineErrors = false}) {
    if (windowSize < 1) throw Exception("Window size must be greater than 0");

    if (windowSize < windowOverlap)
      throw Exception("Window size must be greater than overlap");

    this.windowSize = windowSize;

    if (windowOverlap < 0)
      throw new Exception("Window overlap cannot be negative");
    if (windowOverlap >= windowSize)
      throw new Exception(
          "Window overlap cannot be greater or equals to window size");

    this.windowOverlap = windowOverlap;

    if (modelOrder < 1)
      throw new Exception("Model order cannot be lesser than 1");

    this.modelOrder = modelOrder;

    if (movingAverageOrder < 1)
      throw new Exception("Moving average order cannot be lesser than 1");

    this.movingAverageOrder = movingAverageOrder;

    this.ignoreEngineErrors = ignoreEngineErrors;
  } //FINE COSTRUTTORE

  int get ppeWindowOverlap => windowOverlap ~/ 2;

  int get ppeWindowSize => windowOverlap;

  /// <summary>
  /// Gets the total size of a single sample buffer used by the algorithm.
  /// </summary>
  int get bufferSize => windowSize + windowOverlap;

  /// <summary>
  /// Gets the index where values start overflowing into the next buffer.
  /// </summary>
  int get overflowIndex => windowSize;
} //FINE CLASSE
