//library buflib;

//import 'dart:core';
//import 'dart:html';
//import 'package:intl/intl.dart';
/*
import './BufferSnapshot.dart';
import './DataEntry.dart';
*/
import 'dart:async';
//import 'dart:html';

import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';

//import 'dart:core';
class Buffer {
  late final int _size;

  late List<int> _timestamps;

  late List<double> _accX, _accY, _accZ;

  late List<double> _latitude, _longitude;

  late List<double> _speed;

  late List<double> _bearing;

  late List<int> _accuracy;

  int _fillIndex = 0;

  int _prefillSize = 0;

  //COSTRUTTORE
  Buffer(int size) {
    if (size <= 0) throw new Exception("Size cannot be negative");

    this._size = size;
    //var prova = [];
    this._timestamps = new List<int>.filled(size, 0);

    this._accX = new List<double>.filled(size, 0);
    this._accY = new List<double>.filled(size, 0);
    this._accZ = new List<double>.filled(size, 0);

    this._latitude = new List<double>.filled(size, 0);
    this._longitude = new List<double>.filled(size, 0);

    this._speed = new List<double>.filled(size, 0);

    this._bearing = new List<double>.filled(size, 0);
    this._accuracy = new List<int>.filled(size, 0);
  } //fine costruttore

  int get size => _size;

  int get index => _fillIndex;

  bool get isFull => this._fillIndex >= this._size;

  /// Clears the buffer.
  void clear() {
    this._prefillSize = 0;
    this._fillIndex = 0;
  }

  /* 
   * ! EXCEPTION NON GIUSTA
  */
  void prefill(int prefillSize) {
    if (this._fillIndex != 0)
      throw new Exception("Cannot prefill already filled buffer");
    if (prefillSize < 0) throw new Exception("Cannot prefill negative size");
    if (prefillSize >= _size)
      throw new Exception("Prefill size cannot match or exceed buffer size");

    for (int i = 0; i < prefillSize; i++) {
      this._timestamps[i] = 0;
      this._accX[i] = _accY[i] = _accZ[i] = 0;
      this._speed[i] = 0.0;
      this._bearing[i] = 0.0;
      this._accuracy[i] = 0;
    }

    this._fillIndex = this._prefillSize = prefillSize;
  }

  /*

  * ! DA GAURDARE BENE COME FUNZIONA TIMESPAN

  rappresentano rispettivamente i ticks in un secondo e in 0.5 secondi

  final double _timestampForwardTolerance = TimeSpan.FromSeconds(1).Ticks;

  final double _timestampDelayTolerance = TimeSpan.FromSeconds(0.5).Ticks;

  */

  //ASSUMENDO CHE LA DATA VIENE RIPOSRTATA IN MILLISECONDI

  final int _timestampForwardTolerance = Duration(seconds: 1).inMilliseconds;

  final double _timestampDelayTolerance =
      (Duration(seconds: 1).inMilliseconds) / 2;

  //dovrebbe essere internal quindi con _ davanti e bisogna mettere libreria
  void _record(DataEntry entry) {
    if (this.isFull) throw Exception("Buffer full");

    if (this._fillIndex > this._prefillSize &&
        (entry.timeStamp - this._timestamps[this._fillIndex - 1]) >
            this._timestampDelayTolerance)
      //Gap > 0.5 s detected
      throw new Exception(
          "Timestamp at index $_fillIndex has a ${entry.timeStamp - this._timestamps[this._fillIndex - 1]} delay (tollerance $_timestampDelayTolerance) from previous timestamp (prefilled to $_prefillSize ");

//////////////////////

    //Check for backward-moving timestamps
    int entryTimestamp = entry.timeStamp;

//!DA RIMETTERE
    /*
    if (this._fillIndex > 0 &&
        this._timestamps[_fillIndex - 1] > entryTimestamp) {
      //Non-monotonic timestamp detected
      if (_timestamps[_fillIndex - 1] - entryTimestamp <
          _timestampForwardTolerance) {
        entryTimestamp = _timestamps[_fillIndex - 1];
      } else {
        throw new Exception("Timestamps must be monotonically increasing");
      }
    }*/

///////////////////////////////////////////////////////////

    _timestamps[_fillIndex] = entryTimestamp;
    _accX[_fillIndex] = entry.accelerationX;
    _accY[_fillIndex] = entry.accelerationY;
    _accZ[_fillIndex] = entry.accelerationZ;
    _latitude[_fillIndex] = entry.latitude;
    _longitude[_fillIndex] = entry.longitude;
    _speed[_fillIndex] = entry.speed;
    _bearing[_fillIndex] = entry.bearing;
    _accuracy[_fillIndex] = entry.accuracy;

    this._fillIndex++;
  } //FINE CLASSE RECORD

  num get _middleIndex => _prefillSize + ((_size - _prefillSize) / 2);

  int get firstTimestamp {
    if (_fillIndex <= _prefillSize)
      throw new Exception("No valid timestamp in buffer");

    return _timestamps[_prefillSize];
  }

  int get lastTimestamp {
    if (_fillIndex <= _prefillSize)
      throw new Exception("No valid timestamp in buffer");

    return _timestamps[_fillIndex - 1];
  }
/*
  BufferSnapshot takeSnapshot() {
    return new BufferSnapshot (
              size           : _size,
              timestamps     : new List<int>.from(_timestamps),
              accelerationsX : new List<double>.from(_accX),
              accelerationsY : new List<double>.from(_accY),
              accelerationsZ : new List<double>.from(_accZ),
              latitudes      : new List<double>.from(_latitude),
              longitudes     : new List<double>.from(_longitude),
              speeds         : new List<double>.from(_speed),
              bearings       : new List<double>.from(_bearing),
              accuracies     : new List<int>.from(_accuracy),
              fillIndex      : _fillIndex,
              prefillSize    : _prefillSize
    );

*/

  /// <summary>
  /// Creates a complete copy of the buffer data.
  /// </summary>
  BufferSnapshot takeSnapshot() {
    return new BufferSnapshot(
        this._size,
        this._timestamps /*new List<int>.from(_timestamps)*/,
        this._accX /*new List<double>.from(_accX)*/,
        this._accY /*new List<double>.from(_accY)*/,
        this._accZ /*new List<double>.from(_accZ)*/,
        this._latitude /*new List<double>.from(_latitude)*/,
        this._longitude /*new List<double>.from(_longitude)*/,
        this._speed /*new List<double>.from(_speed)*/,
        this._bearing /*new List<double>.from(_bearing)*/,
        this._accuracy /*new List<int>.from(_accuracy)*/,
        this._fillIndex,
        this._prefillSize);
  }
} //fine classe BUFFER

//####################################################
//
//
// INIZIO CLASSE ENGINE

class Engine {
  late EngineSettings _mySettings;

  late Buffer _primaryBuffer, _secondaryBuffer;

  List<double>? _hammingWindow;

  Engine.constructor1() : this.constructor2(new EngineSettings());

  Engine.constructor2(EngineSettings settings) {
    this._mySettings = settings;
    reset();
  }

  /**
   * <summary>
   * Gets the settings used by this engine.
   * </summary>
   */
  EngineSettings get settings => this._mySettings;
  //Private setter for settings varable
  //set settings(value) => this._mySettings = value;

  /**
   * <summary>
   * Resets the engine with new settings.
   * </summary>
   */
  void updateSettings(EngineSettings settings) {
    this._mySettings = settings;
    reset();
  }

  Buffer get __primaryBuffer => this._primaryBuffer;

  Buffer get __secondaryBuffer => this._secondaryBuffer;

  /**
   * <summary>
   * Resets the engine to its initial state. Current data is lost.
   * </summary>
   */
  void reset() {
    int buffersize = this._mySettings.bufferSize;

    this._primaryBuffer = new Buffer(buffersize);
    this._secondaryBuffer = new Buffer(buffersize);

    this._primaryBuffer.prefill(this._mySettings.windowOverlap);

    this._hammingWindow = null;
  }

  //Cambiato da __hammingWindow a hammingWindow
  List<double>? get hammingWindow {
    this._hammingWindow ??= HammingWindow.generate(this._mySettings.bufferSize);
    return _hammingWindow;
  }

  int qui = 0;

  void register(DataEntry entry) {
    /*
 !!!!!!!!!!!!!!!!!!!!!!!
 L'ho aggiunta io per far si che se i dati si corrompevano
 prima della registrazione, quest'ultima non avvenisse
 Vedi Test6 di errorResilience_rest.dart
 */
    ///Controllo che i dati di entry siano validi
    //this.qui++;
    //print(qui);

    if (!(NumericExtensions.isValid(entry.accelerationX) &&
        NumericExtensions.isValid(entry.accelerationY) &&
        NumericExtensions.isValid(entry.accelerationZ) &&
        NumericExtensions.isValid(entry.latitude) &&
        NumericExtensions.isValid(entry.longitude) &&
        NumericExtensions.isValid(entry.bearing)))
      throw throw EngineComputationException.createFromEngineSnapshot(this);

/*
!!!!!!!!!!!!!!!!!!!!!!!!
*/

    //If we are in overflow position, record entry in secondary buffer as well
    if (this._primaryBuffer.index >= this._mySettings.overflowIndex)
      this._secondaryBuffer._record(entry);
    /*else{
      this._primaryBuffer._record(entry);
    }*/

    this._primaryBuffer._record(entry);

    //If buffer full, perform computation
    if (this._primaryBuffer.isFull) {
      //qui per debugging risultato: 377<
      //qui++;

      _computeResult();

      this._primaryBuffer.clear();

      //Switch buffers
      var tmp = this._primaryBuffer;
      this._primaryBuffer = this._secondaryBuffer;
      this._secondaryBuffer = tmp;
    }
  }

  /// <summary>
  /// Computes PPE on primary buffer.
  /// </summary>
  /// <remarks>
  /// Primary buffer MUST be full.
  /// </remarks>
  void _computeResult() {
    var ppeX = _computePpe(this._primaryBuffer._accX);
    var ppeY = _computePpe(this._primaryBuffer._accY);
    var ppeZ = _computePpe(this._primaryBuffer._accZ);

    var ppe = (ppeX + ppeY + ppeZ) / 3.0;

    //Check for computation errors
    if (!(NumericExtensions.isValid(ppeX) &&
        NumericExtensions.isValid(ppeY) &&
        NumericExtensions.isValid(ppeZ) &&
        NumericExtensions.isValid(ppe))) {
      if (this._mySettings.ignoreEngineErrors) {
        return;
      } else
        throw EngineComputationException.createFromEngineSnapshot(this);
    }

    var r = new Result(
        ppe,
        ppeX,
        ppeY,
        ppeZ,
        this._primaryBuffer._latitude.last,
        this._primaryBuffer._longitude.last,
        this._primaryBuffer.firstTimestamp,
        this._primaryBuffer.lastTimestamp,
        this._primaryBuffer._speed.last,
        this._primaryBuffer._bearing.last,
        this._primaryBuffer._accuracy.last);

    onComputationCompleted(r);
  }

  /// <summary>
  /// Computes the Power Prediction Error on a data set.
  /// </summary>
  double _computePpe(List<double> data) {
    //List<double> newData = List.from(data);

    //In mathematicalExtension
    MathematicalExtensions.detrendOne(data);

    MathematicalExtensions.multiply1(data, hammingWindow);

    List<double> lambda = _estimateAutoRegressiveModel(data);

    //compute error
    double errorAccumulator = 0;
    for (int i = 0; i < this._mySettings.ppeWindowSize; ++i) {
      //temp(k : -1 : k - order)
      var section = ArrayExtensions.createReverseView(
          data,
          i + this._mySettings.ppeWindowOverlap - this._mySettings.modelOrder,
          this._mySettings.modelOrder + 1);

      double error = MathematicalExtensions.matrixProductSum(lambda, section);
      //lambda.matrixProductSum(section);

      errorAccumulator += error * error;
    }

    //Returns mean error for c-th split window
    return (errorAccumulator / this._mySettings.ppeWindowSize.toDouble());
  }

  //PER DEBUGGING, fornisce la funzione all'esterno
  List<double> estimate(List<double> data) =>
      _estimateAutoRegressiveModel(data);

  List<double> _estimateAutoRegressiveModel(List<double> data) {
    var autoCorr = _computeAutoCorrelation(data);

    var lambda = _computeLevinsonDurbin(autoCorr);

    return lambda;
  }

  //PER DEBUGGING, fornisce la funzione all'esterno
  List<double> comp(List<double> data) {
    return _computeAutoCorrelation(data);
  }

  List<double> _computeAutoCorrelation(List<double> data) {
    //Produces (order + 1) results
    //List<double> results = new List.filled(this._mySettings.modelOrder + 1, 0);

    List<double> results = new List.empty(growable: true);

    //Final layout as follows:
    //0 1 ... N-1 N
    //where N is the order of model
    for (int order = 0; order < this._mySettings.modelOrder + 1; ++order) {
      /*results[order] = StatisticalExtensions.autoCorrelation(data, order)
          .reduce((a, b) => a + b);*/
      results.add(StatisticalExtensions.autoCorrelation(data, order)
          .reduce((a, b) => a + b));
    }

    return results;
  }

  List<double> _recomputeLevinsonDurbinA(List<double> A, double k) {
    List<double> ret = new List.filled(A.length + 1, 0);
    //[A.length + 1];

    //Prepend k to return array
    ret[0] = k;

    //Compute rest of array in one pass
    for (int i = 0; i < A.length; ++i) {
      //A - (rev(A) * k)
      ret[i + 1] = A[i] - (A[A.length - 1 - i] * k);
    }

    return ret;
  }

  List<double> _finalizeLevisonDurbinResult(List<double> A) {
    // A = [1; -A(N:-1:1)];
    List<double> result = List<double>.empty(growable: true);
    result.add(1);
/*
    result.addAll(A.reversed);

    for (int i = 1; i < result.length; i++) {
      result[i] = -result[i];
    }
    return result.toList();
*/
    for (var item in A.reversed) {
      result.add(-item);
    }
    return result;
  }

  //PER DEBUGGING
  List<double> levinson(List<double> data) => _computeLevinsonDurbin(data);

  List<double> _computeLevinsonDurbin(List<double> data) {
    //First step

    double k = data[1] / data[0];

    List<double> A = new List<double>.filled(1, k, growable: true);

    //double[] A = new double[] { k };
    double e = (1 - k * k) * data[0];

    for (int i = 1; i < data.length - 1; ++i) {
      double matrixPart = MathematicalExtensions.matrixProductSum(
          A, ArrayExtensions.createView(data, 1, i));
      k = (data[i + 1] - matrixPart) / e;

      //A = _recomputeLevinsonDurbinA(A, k);
      A = new List.from(_recomputeLevinsonDurbinA(A, k));

      e = (1 - k * k) * e;
    }
    return _finalizeLevisonDurbinResult(A);

    //throw StateError("Error in returning value");
  }

  /////////////////////////////////////
  ///
  /*
  
*/
/*
  Stream<EngineComputationEventArgs> computationCompleted(Result r) async* {
    if
    yield new EngineComputationEventArgs(r);
  }
*/
/*
  CustomEvent evt = new CustomEvent(
      'computationCompleted'/* , detail: new EngineComputationEventArgs(result)*/);



  StreamController computationCompleted = new StreamController.broadcast();

  void onComputationCompleted(Result result) {
    computationCompleted.add(new EngineComputationEventArgs(result));
  }

  Stream get eventDone => computationCompleted.stream;

*/
  ///Event
  final StreamController<EngineComputationEventArgs> _computationCompleted =
      StreamController.broadcast(sync: true);

  Stream<EngineComputationEventArgs> get computationCompleted =>
      _computationCompleted.stream;

  void onComputationCompleted(Result result) {
    if (_computationCompleted.hasListener) {
      _computationCompleted.add(EngineComputationEventArgs(result));
    }
  }

////////////////////////////////////////////
/*
  EventHandler<EngineComputationEventArgs>? computationCompleted;

  void onComputationCompleted(Result result) {
    var evt = computationCompleted;
    //if (evt != null) evt(this, new EngineComputationEventArgs(result));
    if (evt != null) evt(new EngineComputationEventArgs(result));
  }

//MANCANO EVENTI
*/
} //FINE CLASSE ENGINE

/// <summary>
/// A mathematical exception occuring during the execution of the SmartRoadSense algorithm.
/// </summary>
class EngineComputationException implements Exception {
  BufferSnapshot _primarySnapshot, _secondarySnapshot;

  EngineComputationException._EngineComputationException(
      this._primarySnapshot, this._secondarySnapshot);
  /* {
    this._primarySnapshot = primary;
    this._secondarySnapshot = secondary;
  }*/

  //EngineComputationException(this._primarySnapshot, this._secondarySnapshot);

  static EngineComputationException createFromEngineSnapshot(Engine engine) {
    return new EngineComputationException._EngineComputationException(
        engine._primaryBuffer.takeSnapshot(),
        engine._secondaryBuffer.takeSnapshot());
  }

  /// <summary>
  /// Gets the snapshot of the primary engine buffer.
  /// </summary>
  BufferSnapshot get primaryBufferSnapshot => this._primarySnapshot;

  /// <summary>
  /// Gets the snapshot of the secondary engine buffer.
  /// </summary>
  BufferSnapshot get secondaryBufferSnapshot => this._secondarySnapshot;
} //fine classe EngineComputationException
