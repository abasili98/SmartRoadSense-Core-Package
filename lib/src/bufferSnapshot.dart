//import 'dart:core';

//DA MODIFICARE PER COSTRUTTORE VEDI results.dart
class BufferSnapshot {
  int _size;

  List<int> _timestamps;

  List<double> _accelerationsX, _accelerationsY, _accelerationsZ;

  List<double> _latitudes, _longitudes;

  List<double> _speeds;
  List<double> _bearings;

  List<int> _accuracies;

  int _fillIndex;
  int _prefillSize;

  BufferSnapshot(
      this._size,
      this._timestamps,
      this._accelerationsX,
      this._accelerationsY,
      this._accelerationsZ,
      this._latitudes,
      this._longitudes,
      this._speeds,
      this._bearings,
      this._accuracies,
      this._fillIndex,
      this._prefillSize);
  /*{
    //this.size = size;
    this.timestamps = timestamps;
    this.accelerationsX = x;
    this.accelerationsY = y;
    this.accelerationsZ = z;
    this.latitudes = lat;
    this.longitudes = long;
    this.speeds = s;
    this.bearings = bea;
    this.fillIndex = fill;
    this.prefillSize = pre;
  }*/

  int get size => this._size;
  List<int> get timestamps => this._timestamps;
  List<double> get accelerationsX => this._accelerationsX;
  List<double> get accelerationsY => this._accelerationsY;
  List<double> get accelerationsZ => this._accelerationsZ;
  List<double> get latitudes => this._latitudes;
  List<double> get longitudes => this._longitudes;
  List<double> get speeds => this._speeds;
  List<double> get bearings => this._bearings;
  List<int> get accuracies => this._accuracies;
  int get fillIndex => this._fillIndex;
  int get prefillSize => this._prefillSize;
} //FINE CLASSE
