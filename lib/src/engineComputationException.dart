/*

!! IN BUFFER
import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
import 'dart:core';

/// <summary>
/// A mathematical exception occuring during the execution of the SmartRoadSense algorithm.
/// </summary>
class EngineComputationException implements Exception {
  late BufferSnapshot _primarySnapshot, _secondarySnapshot;

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
} //fine classe
*/
