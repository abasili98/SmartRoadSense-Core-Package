import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
import 'package:test/test.dart';

void main() {
  /*
    <summary>
    Checks whether invalid input values generate exceptions.
    </summary>
  */
  group('NAN Input', () {
    var engine = new Engine.constructor1();
    test('Test 1', () {
      /*engine.register(new DataEntry.constructor1(
          DateTime.now(), double.nan, 0.0, 0.0, 0.0, 0.0, 0, 0, 0));
*/
      expect(
          () => engine.register(new DataEntry.constructor1(
              DateTime.now(), double.nan, 0.0, 0.0, 0.0, 0.0, 0, 0, 0)),
          throwsArgumentError);
    }); //fine test 1

    test('Test 2', () {
      expect(
          () => engine.register(new DataEntry.constructor1(
              DateTime.now(), 0.0, double.infinity, 0.0, 0.0, 0.0, 0, 0, 0)),
          throwsArgumentError);
    }); //fine test 2

    test('Test 3', () {
      expect(
          () => engine.register(new DataEntry.constructor1(DateTime.now(), 0.0,
              0.0, double.negativeInfinity, 0.0, 0.0, 0, 0, 0)),
          throwsArgumentError);
    }); //fine test 3

    test('Test 4', () {
      expect(
          () => engine.register(new DataEntry.constructor1(
              DateTime.now(), 0.0, 0.0, 0.0, double.nan, 0.0, 0, 0, 0)),
          throwsArgumentError);
    }); //fine test 4

    test('Test 5', () {
      expect(
          () => engine.register(new DataEntry.constructor1(
              DateTime.now(), 0.0, 0.0, 0.0, 0.0, double.nan, 0, 0, 0)),
          throwsArgumentError);
    }); //fine test 5
  }); //fine group NAN Input

  /// <summary>
  /// Checks whether malformed input (created forcibly via reflection) which generates invalid output
  /// raises an exception (when output data contains NaN values).
  /// </summary>
  group('NAN Output', () {
    var engine =
        new Engine.constructor2(new EngineSettings(ignoreEngineErrors: false));
/*
    engine.ComputationCompleted += (sender, e) => {
                Console.WriteLine("PPE {0}", e.Result.Ppe);
            };

*/

    //Future<EngineComputationEventArgs> e = await engine.computationCompleted(engine.);

    engine.computationCompleted.forEach((e) => print("PPE ${e.result.ppe}"));

    var fakeEntry = new DataEntry.constructor1(
        DateTime.now(), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0);

    //var accXProperty = getProperty(fakeEntry, "AccelerationX");

    fakeEntry.accelerationX = double.nan;

    print(
        "${fakeEntry.accelerationX} ${fakeEntry.accelerationY} ${fakeEntry.accelerationY}");

    //Com'era originariamente genera l'errore soltato se il buffer primario
    //è pieno (isFull) e gli viene passata un'accelerazione sbagliata
    //Quindi genera un errore solo se primary buffer isFull e dati non sono validi

    //Cambiata in modo tale rilevi l'errore in questo caso
    test("Test 6", () {
      expect(
          () => {
                for (int i = 0; i < engine.settings.windowSize - 1; ++i)
                  {
                    engine.register(fakeEntry),
                  }
              },
          throwsA(isA<EngineComputationException>()));
    });
  }); //fine group NAN Output
}
