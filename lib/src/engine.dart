/*
  * !! IN BUFFER.dart


import 'dart:web_sql';
import 'dart:math';

import 'package:dartz/dartz_streaming.dart';
*/


/*
import '../SmartRoadSense-Core-Package.dart';
//import 'buffer.dart';

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
  set settings(value) => this._mySettings = value;

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

    _primaryBuffer.prefill(this._mySettings.windowOverlap);

    this._hammingWindow = null;
  }

  //Cambiato da __hammingWindow a hammingWindow
  List<double>? get hammingWindow {
    this._hammingWindow ??= HammingWindow.generate(this._mySettings.bufferSize);
    return _hammingWindow;
  }

  void register(DataEntry entry) {
    //If we are in overflow position, record entry in secondary buffer as well
    if (this._primaryBuffer.index >= this._mySettings.overflowIndex)
      this._secondaryBuffer._record(entry);

    this._primaryBuffer._record(entry);

    this._primaryBuffer._

    //If buffer full, perform computation
    if (this._primaryBuffer.isFull) {
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

    var ppe = (ppeX + ppey + ppeZ) / 3.0;

    //Check for computation errors
    if (!(NumericExtensions.isValid(ppeX) && NumericExtensions.isValid(ppeY) && NumericExtensions.isValid(ppeZ) && NumericExtensions.isValid(ppe))) {
      if (this._mySettings.ignoreEngineErrors) {
        return;
      } else
        throw EngineComputationException.createFromEngineSnapshot(this);
    }

    var r = new Result(ppe,
     ppeX,
     ppeY,
     ppeZ,
     _primaryBuffer._latitude.last(),
     _primaryBuffer._longitude.last(),
     _primaryBuffer.firstTimestamp,
     _primaryBuffer.lastTimestamp,
     _primaryBuffer._speed.last,
     _primaryBuffer._accuracy.last
     );

    onComputationCompleted(r);
  }


  /// <summary>
  /// Computes the Power Prediction Error on a data set.
  /// </summary>
  double _computePpe(List<double> data)
  {
    //DA GUARDARE
    //data.detendOne();
    MathematicalExtensions.detrendOne(data);
    List<double> lambda = estimateAutoRegressiveModel(data);

    //compute error
    double errorAccumulator = 0;
    for(int i = 0; i < this._mySettings.ppeWindowSize; ++i){
      //temp(k : -1 : k - order)      
      var section = data.
              (i + this._mySettings.ppeWindowOverlap - this._mySettings.modelOrder, this._mySettings.modelOrder + 1);

      double error = lambda.matrixProductSum(section);

      errorAccumulator += error * error;

    }

    //Returns mean error for c-th split window
    return (errorAccumulator / this._mySettings.ppeWindowSize);

  }


  List<double> _computeAutoCorrelation(List<double> data){
    //Produces (order + 1) results
    List<double> results = [this._mySettings.modelOrder + 1];

    //Final layout as follows:
    //0 1 ... N-1 N
    //where N is the order of model
    for(int order = 0; order < this._mySettings.modelOrder + 1; ++order){
      results[order] = data.autoCorrelation(order).reduce((a,b) => a + b);
    }

    return results;
  }

} //FINE CLASSE ENGINE
*/