/// <summary>
/// Represents a result computed by the engine.
/// </summary>
class Result {
  double _ppe;
  double _ppeX;
  double _ppeY;
  double _ppeZ;

  double _latitude;
  double _longitude;

  int _firstTimestamp;
  int _lastTimestamp;

  double _speed;
  double _bearing;
  int _accuracy;

/*
  Result(double ppe, double ppex, double ppey, double ppez, double lat,
      double lon, int fir, int last, double s, double b, int a)
      : this._ppe = ppe, this._ppeX = ppex, this._ppeY = ppey, this._ppeZ = ppez,
      this._latitude = lat, this._longitude = lon, this._firstTimestamp = fir,
      this._lastTimestamp = last, this._speed = s, this._bearing = b, this._accuracy =a
  {}
*/
  Result(
      this._ppe,
      this._ppeX,
      this._ppeY,
      this._ppeZ,
      this._latitude,
      this._longitude,
      this._firstTimestamp,
      this._lastTimestamp,
      this._speed,
      this._bearing,
      this._accuracy);
  /*{
    this.ppe = ppe;
    this.ppeX = ppeX;
    this.ppeY = ppeY;
    this.ppeZ = ppeZ;
    this.latitude = latitude;
    this.longitude = longitude;
    this.firstTimestamp = firstTimestamp;
    this.lastTimestamp = lastTimestamp;
    this.speed = speed;
    this.accuracy = accuracy;
  }*/

  double get ppe => this._ppe;
  double get ppeX => this._ppeX;
  double get ppeY => this._ppeY;
  double get ppeZ => this._ppeZ;
  double get longitude => this._longitude;
  double get latitudee => this._latitude;
  int get firstTimestamp => this._firstTimestamp;
  int get lastTimestamp => this._lastTimestamp;
  double get speed => this._speed;
  double get bearing => this._bearing;
  int get accuracy => this._accuracy;
}
