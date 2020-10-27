import 'dart:math';

import 'package:flutter/cupertino.dart';

class SortingProvider extends ChangeNotifier {
  static const bubbleString = "Bubble Sort";
  static const insertionString = "Insertion Sort";
  static const selectionString = "Selection Sort";
  static const mergeString = "Merge Sort";

  final Random _rng = Random();
  final List<String> availableAlgos = [
    bubbleString,
    insertionString,
    selectionString,
    mergeString,
  ];
  String selectedAlgo;
  List<int> listToSort = [];
  bool isAlgoRunning;

  SortingProvider() {
    isAlgoRunning = false;
    selectedAlgo = bubbleString;
    generateRandomList();
  }

  void setSelectedAlgo(String selectedAlgo) {
    this.selectedAlgo = selectedAlgo;
    notifyListeners();
  }

  void generateRandomList() {
    if (!isAlgoRunning) {
      listToSort = List.generate(412, (_) => _rng.nextInt(320) + 1);
      notifyListeners();
    }
  }

  void swap(List<int> list, int i, int j) {
    int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  Future<void> runCorrectAlgo() async {
    if (!isAlgoRunning) {
      switch (selectedAlgo) {
        case bubbleString:
          await _bubbleSort();
          break;
        case insertionString:
          await _insertionSort();
          break;
        case selectionString:
          await _selectionSort();
          break;
        case mergeString:
          await _mergeSort(this.listToSort, 0, this.listToSort.length - 1);
          break;
        default:
          await _bubbleSort();
          break;
      }
    }
  }

  Future<void> _bubbleSort() async {
    isAlgoRunning = true;
    for (int i = 0; i < listToSort.length; i++) {
      for (int j = 0; j < listToSort.length - 1; j++) {
        if (listToSort[j] > listToSort[j + 1]) {
          int currentNum = listToSort[j];
          listToSort[j] = listToSort[j + 1];
          listToSort[j + 1] = currentNum;
        }
        await Future.delayed(Duration(microseconds: 600));
        notifyListeners();
      }
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  Future<void> _insertionSort() async {
    isAlgoRunning = true;
    for (int i = 0; i < listToSort.length; i++) {
      int x = listToSort[i];
      int j = i;

      while (j > 0 && listToSort[j - 1] > x) {
        listToSort[j] = listToSort[j - 1];
        listToSort[j - 1] = x;
        j--;
      }

      listToSort[j] = x;
      await Future.delayed(Duration(milliseconds: 35));
      notifyListeners();
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  Future<void> _selectionSort() async {
    isAlgoRunning = true;
    for (int i = listToSort.length - 1; i >= 0; i--) {
      int first = 0;

      for (int j = 1; j <= i; j++) {
        if (listToSort[j] > listToSort[first]) first = j;
      }

      swap(listToSort, first, i);
      await Future.delayed(Duration(milliseconds: 35));
      notifyListeners();
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  Future<void> _mergeSort(List<int> list, int leftIndex, int rightIndex) async {
    isAlgoRunning = true;
    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(list, leftIndex, middleIndex);
      await _mergeSort(list, middleIndex + 1, rightIndex);

      await _merge(list, leftIndex, middleIndex, rightIndex);
    }
    isAlgoRunning = false;
    notifyListeners();
  }

  Future<void> _merge(
      List<int> list, int leftIndex, int middleIndex, int rightIndex) async {
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    List<int> leftList = List<int>(leftSize);
    List<int> rightList = List<int>(rightSize);

    for (int i = 0; i < leftSize; i++) {
      leftList[i] = list[leftIndex + i];
    }

    for (int j = 0; j < rightSize; j++) {
      rightList[j] = list[middleIndex + j + 1];
    }

    int i = 0;
    int j = 0;
    int k = leftIndex;

    while (i < leftSize && j < rightSize) {
      if (leftList[i] <= rightList[j]) {
        list[k] = leftList[i];
        i++;
      } else {
        list[k] = rightList[j];
        j++;
      }
      await Future.delayed(Duration(milliseconds: 10));
      notifyListeners();
      k++;
    }

    while (i < leftSize) {
      list[k] = leftList[i];
      i++;
      k++;
    }

    while (j < rightSize) {
      list[k] = rightList[j];
      j++;
      k++;
    }
  }
}
