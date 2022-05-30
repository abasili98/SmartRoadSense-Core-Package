//import 'package:smartsoadsense_core_package/SmartRoadSense-Core-Package.dart';
import 'dart:collection';

import 'dart:math';

class ArrayExtensions {
  /// <summary>
  /// Creates a shallow copy of an array.
  /// </summary>
  static List shallowCopy(List source) {
    //return new List.from(source);
    return List.castFrom(source);
    //source.cast();
  }

  /// <summary>
  /// Creates a view on an array without copying any data.
  /// </summary>
  /// <remarks>
  /// The generated view accesses a subset of the original array.
  /// </remarks>
  /*
  !!DEVONO TORNARE LISTE PER LE QUALI LE COPIE MODIFICANO ANCHE L'ORIGINALE??
  */
  static List createView(List source, int start, int length) {
    if (source.length - start < length)
      throw Exception("Cannot create view on array (too short)");

    //var pointer = new PointList(source,)

    //non fa
    //return source.sublist(start, length + start);
    //source[0] = -1.0;
    //return List.castFrom(source);
    return ArrayView(source, start, length);

    /*List copyList = new List.from(source.cast());
    List.copyRange(copyList, 0, source.cast(),start,length+1);
    return copyList;*/

    //return List.from(source.toList().sublist(start, length + start));
    //return new List.from(source).getRange(start, length + start);

    //return List.of(source.cast());
    //return List.of(source);
    //return List.from(source);
    //return source.toList().sublist(start, length + start).cast();
  }

  /// <summary>
  /// Creates a reverse-access view on an array without copying any data.
  /// </summary>
  /// <remarks>
  /// The generated view accesses a subset of the original array in
  /// reverse order. The subset is meant to be on the original array layout,
  /// accessing its item in reverse order.
  /// </remarks>
  static List createReverseView(List source, int start, int length) {
    if (source.length - start < length)
      throw Exception("Cannot create view on array (too short)");

    //Ritorna una nuova lista
    //return source.toList().sublist(start, length + start).reversed.toList();
    return ReverseArrayView(source, start, length);
  }
/*
  Ritorna Iterable in generale 
  static Iterable createReverseView1(Iterable source, int start, int length){
    if (source.length - start < length)
      throw Exception("Cannot create view on array (too short)");

    Ritorna un Iterator  
    return source.toList().sublist(start, length + start).reversed;


  }
*/

}

/*
class _arrayView<T> implements List<T> {
  late List _source;
  late int  _start;
  late int  _length;

  _arrayView.constructor(List source, int start, int length) {
    if (source.length - start < length)
      throw new RangeError("Cannot create view on array (too short)");

    this._source = source;
    this._start  = start;
    this._length = length;
  }

  //Note: index check disabled for performance reasons
  //if (index >= _length)
   //    throw new ArgumentOutOfRangeException();
  List<T> get arrayView (int index) => _source[_start + index];
 /* {
    //Note: index check disabled for performance reasons
    //if (index >= _length)
    //    throw new ArgumentOutOfRangeException();
    return _source[_start + index];
  }*/

  set arrayView (int value) => this._source[_start + index] = value;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
*/
/*
class ArrayView {
  late List _pList;
  late int _start, length;

  ArrayView(List source, int start, int length) {
    if (source.length - start < length)
      throw new RangeError("Cannot create the array (too short)");
    this._pList = source;
    this._start = start;
    this.length = length;
  }

  List get list => this._pList;

  //num get elementAt(int i)=> this._pList[]

}*/

class ArrayView implements List {
  @override
  var first;

  @override
  var last;

  //Source LIST
  late List _pList;

  @override
  late int length;

  late int _start;

  ArrayView(List source, int start, int length) {
    this._pList = List.castFrom(source);
    this._start = start;
    this.length = length;
  }

  @override
  List operator +(List other) {
    // TODO: implement +
    throw UnimplementedError();
  }

  @override
  operator [](int index) {
    //Note: index check disabled for performance reasons
    //if (index >= this._length)
    //    throw new RangeError();
    return this._pList[index + _start];
  }

  @override
  void operator []=(int index, value) {
    this._pList[this._start + index] = value;
  }

  @override
  void add(value) {
    // TODO: implement add
  }

  @override
  void addAll(Iterable iterable) {
    // TODO: implement addAll
  }

  @override
  bool any(bool Function(dynamic element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Map<int, dynamic> asMap() {
    // TODO: implement asMap
    throw UnimplementedError();
  }

  @override
  List<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  bool contains(Object? element) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  elementAt(int index) {
    // TODO: implement elementAt
    //return this._pList[_start + index];
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(dynamic element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(dynamic element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  void fillRange(int start, int end, [fillValue]) {
    // TODO: implement fillRange
  }

  @override
  firstWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(
      T initialValue, T Function(T previousValue, dynamic element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable followedBy(Iterable other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(dynamic element) action) {
    // TODO: implement forEach
  }

  @override
  Iterable getRange(int start, int end) {
    // TODO: implement getRange
    throw UnimplementedError();
  }

  @override
  int indexOf(element, [int start = 0]) {
    // TODO: implement indexOf
    throw UnimplementedError();
  }

  @override
  int indexWhere(bool Function(dynamic element) test, [int start = 0]) {
    // TODO: implement indexWhere
    throw UnimplementedError();
  }

  @override
  void insert(int index, element) {
    // TODO: implement insert
  }

  @override
  void insertAll(int index, Iterable iterable) {
    // TODO: implement insertAll
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();

  @override
  // TODO: implement iterator
  Iterator get iterator => throw UnimplementedError();

  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  int lastIndexOf(element, [int? start]) {
    // TODO: implement lastIndexOf
    throw UnimplementedError();
  }

  @override
  int lastIndexWhere(bool Function(dynamic element) test, [int? start]) {
    // TODO: implement lastIndexWhere
    throw UnimplementedError();
  }

  @override
  lastWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  Iterable<T> map<T>(T Function(dynamic e) toElement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  reduce(Function(dynamic value, dynamic element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  bool remove(Object? value) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  removeAt(int index) {
    // TODO: implement removeAt
    throw UnimplementedError();
  }

  @override
  removeLast() {
    // TODO: implement removeLast
    throw UnimplementedError();
  }

  @override
  void removeRange(int start, int end) {
    // TODO: implement removeRange
  }

  @override
  void removeWhere(bool Function(dynamic element) test) {
    // TODO: implement removeWhere
  }

  @override
  void replaceRange(int start, int end, Iterable replacements) {
    // TODO: implement replaceRange
  }

  @override
  void retainWhere(bool Function(dynamic element) test) {
    // TODO: implement retainWhere
  }

  @override
  // TODO: implement reversed
  Iterable get reversed => throw UnimplementedError();

  @override
  void setAll(int index, Iterable iterable) {
    // TODO: implement setAll
  }

  @override
  void setRange(int start, int end, Iterable iterable, [int skipCount = 0]) {
    // TODO: implement setRange
  }

  @override
  void shuffle([Random? random]) {
    // TODO: implement shuffle
  }

  @override
  // TODO: implement single
  get single => throw UnimplementedError();

  @override
  singleWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable skipWhile(bool Function(dynamic value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  void sort([int Function(dynamic a, dynamic b)? compare]) {
    // TODO: implement sort
  }

  @override
  List sublist(int start, [int? end]) {
    // TODO: implement sublist
    throw UnimplementedError();
  }

  @override
  Iterable take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Iterable takeWhile(bool Function(dynamic value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable where(bool Function(dynamic element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }
}

class ReverseArrayView implements List {
  @override
  var first;

  @override
  var last;

  //source LIST
  late List _pList;

  @override
  late int length;

  late int _endStart;

  ReverseArrayView(List source, int start, int length) {
    this._pList = List.castFrom(source);
    this._endStart = start + length - 1;
    this.length = length;
  }

  @override
  List operator +(List other) {
    // TODO: implement +
    throw UnimplementedError();
  }

  @override
  operator [](int index) {
    //Note: index check disabled for performance reasons
    //if (index >= _length)
    //    throw new RangeError("");
    return this._pList[this._endStart - index];
  }

  @override
  void operator []=(int index, value) {
    this._pList[_endStart - index] = value;
  }

  @override
  void add(value) {
    // TODO: implement add
  }

  @override
  void addAll(Iterable iterable) {
    // TODO: implement addAll
  }

  @override
  bool any(bool Function(dynamic element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Map<int, dynamic> asMap() {
    // TODO: implement asMap
    throw UnimplementedError();
  }

  @override
  List<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  bool contains(Object? element) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(dynamic element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(dynamic element) toElements) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  void fillRange(int start, int end, [fillValue]) {
    // TODO: implement fillRange
  }

  @override
  firstWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(
      T initialValue, T Function(T previousValue, dynamic element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable followedBy(Iterable other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(dynamic element) action) {
    // TODO: implement forEach
  }

  @override
  Iterable getRange(int start, int end) {
    // TODO: implement getRange
    throw UnimplementedError();
  }

  @override
  int indexOf(element, [int start = 0]) {
    // TODO: implement indexOf
    throw UnimplementedError();
  }

  @override
  int indexWhere(bool Function(dynamic element) test, [int start = 0]) {
    // TODO: implement indexWhere
    throw UnimplementedError();
  }

  @override
  void insert(int index, element) {
    // TODO: implement insert
  }

  @override
  void insertAll(int index, Iterable iterable) {
    // TODO: implement insertAll
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();

  @override
  // TODO: implement iterator
  Iterator get iterator => throw UnimplementedError();

  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  int lastIndexOf(element, [int? start]) {
    // TODO: implement lastIndexOf
    throw UnimplementedError();
  }

  @override
  int lastIndexWhere(bool Function(dynamic element) test, [int? start]) {
    // TODO: implement lastIndexWhere
    throw UnimplementedError();
  }

  @override
  lastWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  Iterable<T> map<T>(T Function(dynamic e) toElement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  reduce(Function(dynamic value, dynamic element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  bool remove(Object? value) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  removeAt(int index) {
    // TODO: implement removeAt
    throw UnimplementedError();
  }

  @override
  removeLast() {
    // TODO: implement removeLast
    throw UnimplementedError();
  }

  @override
  void removeRange(int start, int end) {
    // TODO: implement removeRange
  }

  @override
  void removeWhere(bool Function(dynamic element) test) {
    // TODO: implement removeWhere
  }

  @override
  void replaceRange(int start, int end, Iterable replacements) {
    // TODO: implement replaceRange
  }

  @override
  void retainWhere(bool Function(dynamic element) test) {
    // TODO: implement retainWhere
  }

  @override
  // TODO: implement reversed
  Iterable get reversed => throw UnimplementedError();

  @override
  void setAll(int index, Iterable iterable) {
    // TODO: implement setAll
  }

  @override
  void setRange(int start, int end, Iterable iterable, [int skipCount = 0]) {
    // TODO: implement setRange
  }

  @override
  void shuffle([Random? random]) {
    // TODO: implement shuffle
  }

  @override
  // TODO: implement single
  get single => throw UnimplementedError();

  @override
  singleWhere(bool Function(dynamic element) test, {Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable skipWhile(bool Function(dynamic value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  void sort([int Function(dynamic a, dynamic b)? compare]) {
    // TODO: implement sort
  }

  @override
  List sublist(int start, [int? end]) {
    // TODO: implement sublist
    throw UnimplementedError();
  }

  @override
  Iterable take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Iterable takeWhile(bool Function(dynamic value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable where(bool Function(dynamic element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }
}
