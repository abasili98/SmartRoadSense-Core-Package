import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';

class DataEntry {
  late int timeStamp;

  late double accelerationX, accelerationY, accelerationZ;

  late double latitude, longitude;

  late double speed;

  late double bearing;

  late int accuracy;

  //COSTRUTTORE 1
  DataEntry.constructor1(
      DateTime time,
      double accX,
      double accY,
      double accZ,
      double latitude,
      double longitude,
      double speed,
      double bearing,
      int accuracy)
      //in time ci va .Now() prima di miilsecondsSinceEpoch() ????????
      : this.constructor2(time.millisecondsSinceEpoch, accX, accY, accZ,
            latitude, longitude, speed, bearing, accuracy);
  //FINE COSTRUTTORE 1

  /*{
    this.constructor2(time.millisecondsSinceEpoch, accX, accY, accZ,
                      latitude, longitude, speed, bearing, accuracy);
  }*/

  //COSTRUTTORE 2
  /*DataEntry.constructor2(
      int timestamp,
      double accX,
      double accY,
      double accZ,
      double latitude,
      double longitude,
      double speed,
      double bearing,
      int accuracy) {
    this.timeStamp = timestamp;

    this.accelerationX = accX;

    this.accelerationY = accY;
    this.accelerationZ = accZ;

    this.latitude = latitude;
    this.longitude = longitude;

    this.speed = speed;

    this.bearing = bearing;

    this.accuracy = accuracy;

    //if(!(accX.isNaN   ))
  } */

  DataEntry.constructor2(
      this.timeStamp,
      this.accelerationX,
      this.accelerationY,
      this.accelerationZ,
      this.latitude,
      this.longitude,
      this.speed,
      this.bearing,
      this.accuracy) {
    this.timeStamp = timeStamp;

    if (!(NumericExtensions.isValid(accelerationX) &&
        NumericExtensions.isValid(accelerationY) &&
        NumericExtensions.isValid(accelerationZ)))
      throw new ArgumentError("Invalid acceleration value");

    this.accelerationX = accelerationX;
    this.accelerationY = accelerationY;
    this.accelerationZ = accelerationZ;

    if (!(NumericExtensions.isValid(latitude) &&
        NumericExtensions.isValid(longitude)))
      throw new ArgumentError("Invalid geographic value");

    this.latitude = latitude;
    this.longitude = longitude;

    this.speed = speed;

    if (!NumericExtensions.isValid(bearing))
      throw new ArgumentError("Invalid bearing value");
    this.bearing = bearing;

    this.accuracy = accuracy;
  }

  //FINE COSTRUTTORE 2

  //GETTERS DI DEFAULT

/* /// <summary>
  /// Gets the timestamp, expressed as ticks from the UNIX epoch.
  /// </summary>
  /// <value>The timestamp.</value>
  int get timeStamp => this.timeStamp;

  double get accelerationX => this.accelerationX;

  double get accelerationY => this.accelerationY;

  double get accelerationZ => this.accelerationZ;

*/

} //FINE CLASSE
