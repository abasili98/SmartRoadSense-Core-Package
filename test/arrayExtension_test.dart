/*
!Quasi finito, vedi commenti sotto con !. Il resto viene tutto
*/

//import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
//import 'dart:collection';

import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
import 'package:test/test.dart';
//import 'package:test/expect.dart';
//già negli altri import ma non faceva
import 'package:collection/collection.dart';

import 'checkExtensions.dart';

//import 'dart:ffi';

void main() {
  //Function eq = const ListEquality().equals;

  List<double> tester = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  //Iterable? i;

  group('Array View', () {
    test('Dovrebbe ritornare true1', () {
      //var subList = tester.getRange(1, 4).toList();
      List subList = ArrayExtensions.createView(tester, 1, 3);
      List<double> testList = [2, 3, 4];

      expect(CheckExtensions.assertEquals(subList, testList), null);
    });

    test('Dovrebbe ritornare true2', () {
      //var subList = tester.getRange(0, 5).toList();

      var subList = ArrayExtensions.createView(tester, 0, 5);

      List<double> testList = [1, 2, 3, 4, 5];

      expect(CheckExtensions.assertEquals(subList, testList), null);
    });

    test('Dovrebbe ritornare true3', () {
      //var subList = tester.getRange(7, 8).toList();

      var subList = ArrayExtensions.createView(tester, 7, 1);

      List<double> testList = [8];

      expect(CheckExtensions.assertEquals(subList, testList), null);
    });

    test('Dovrebbe ritornare true4', () {
      //like create view
      //var subList = tester.getRange(5, 5).toList();

      var subList = ArrayExtensions.createView(tester, 5, 0);

      List<double> testList = [];

      expect(CheckExtensions.assertEquals(subList, testList), null);
    });
  }); //FINE GROUP array Equality

  /*
  ! Cosa dovrebbe tornare? Quali sono gli expect giusti?
  */
  group('Array View Mod', () {
    test('Dovrebbe ritornare true5', () {
      List<double> test =
          List.from(({0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0}));

      //var subList = tester.getRange(1, 4).toList();

      var view = ArrayExtensions.createView(test, 1, 3);

      /*List point = List.castFrom(test);

      print(point.reversed);
      print(test);

      */

/*
      print(test);
      print(point);
      point[0] = -1.0;
      print(test);
*/
      //NON CAMBIANO I VALORI
      //var view = new List.of(test);

      //SI MODIFICANO ENTRAMBI
      //var view = test.cast();

      //NON CAMBIANO IN ENTRAMBE
      //var view = new List.from(test);

      //VALORI CAMBIANO IN ENTRAMBE
      //List view = test;

      /*NON CAMBIA ENTRAMBE
      List<double> view = new List.empty(growable: true);
      view.addAll(test);
      */
      //ListEquality().equals(list1, list2);

      //Iterable iter = new Iterable.empty();

      view[0] = -1.0;
      view[2] = -3.0;

      expect(test[0] == 0, true);
      expect(test[1] == -1, true);
      expect(test[2] == 2, true);
      expect(test[3] == -3, true);
    });
  }); //FINE GROUP arrayViewMod

  //VIENE
  test('Reverse Array View: Expected True', () {
    var aRev = ArrayExtensions.createReverseView(tester, 0, tester.length);

    

    expect(CheckExtensions.assertEquals(aRev, tester.reversed.toList()), null);

    var aRev1 = ArrayExtensions.createReverseView(tester, 3, 3);

    //expect(eq(aRev1, tester.skip(3).take(3).toList().reversed), true);

    expect(
        CheckExtensions.assertEquals(
            aRev1, tester.skip(3).take(3).toList().reversed.toList()),
        null);
  });


  group('Reverse Array Mod', () {
    List<double> aTest =
        List.from(({0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0}));

    var view = ArrayExtensions.createReverseView(aTest, 1, 3);

    view[0] = -1.0;
    view[2] = -3.0;

    print("Lunghezza aTest: ${aTest.length}\nLunghezza view: ${view.length}");
    test('Reverse Array Mod - Test 1', () {
      expect(aTest[0] == 0, true);
      expect(aTest[1] == -3, true);
      expect(aTest[2] == 2, true);
      expect(aTest[3] == -1, true);
      expect(aTest[8] == 8, true);
      expect(aTest[9] == 9, true);
    });
  }); //FINE GROUP REVERSE ARRAY MOD

/*
  arrayView() {
    //true o false? Da capire cosa fa il codice
    //expect(tester.getRange(1, 3) == [2, 3, 4], true);
    expect(eq(tester.getRange(1, 3), [2, 3, 4]), true);

    //expect(tester.getRange(0, 6) == [1, 2, 3, 4, 5], true);
    expect(eq(tester.getRange(0, 6), [1, 2, 3, 4, 5]), true);


    //expect(tester.getRange(7, 0) == [8], true);
    expect(eq(tester.getRange(7, 8), [8]), true);

    //expect(tester.getRange(5, 0) == [], true); //new List probabilmente
    expect(eq(tester.getRange(5, 5), [], true), true);
  
  }

  arrayViewMod() {}*/
}
