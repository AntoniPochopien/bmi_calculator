import 'package:flutter/material.dart';
import 'dart:math';

class BmiProvider with ChangeNotifier {
  double heightValue = 160;
  double weightValue = 60;
  double heightMax = 250.00;
  double weightMax = 200.00;
  int heightUnit = 0;
  int weightUnit = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  double bmiResult(double personHeight, double personWeight) {
    if (personHeight == 0) {
      return 0.0; //handle situation of dividing 0 by 0
    }
    if (heightUnit == 1) {
      personHeight = personHeight * 30.48; //converting ft to cm
    }
    if (weightUnit == 1) {
      personWeight = personWeight * 0.45; //converting lb to kg
    }
    return double.parse(
        (personWeight / pow(personHeight / 100, 2)).toStringAsFixed(2));
  }

  void setWeightValue(double value) {
    weightValue = value;
    notifyListeners();
  }

  void setHeightValue(double value) {
    heightValue = value;
    notifyListeners();
  }

  //dropdownbutton function which controlls height measurement units. Change sliders maxvalue depend on selected unit
  void dropdownCallBackHeight(int? unit) {
    if (unit == 1) {
      heightUnit = 1;
      heightValue = 5;
      heightMax = 8;
      heightController.text = '5';
      notifyListeners();
    } else {
      heightUnit = 0;
      heightValue = 160;
      heightMax = 250;
      heightController.text = '160';
      notifyListeners();
    }
  }

  //dropdownbutton function which controlls weight measurement units. Change sliders maxvalue depend on selected unit
  void dropdownCallBackWeight(int? unit) {
    if (unit == 1) {
      weightUnit = 1;
      weightValue = 120;
      weightMax = 400;
      weightController.text = '120';
      notifyListeners();
    } else {
      weightUnit = 0;
      weightValue = 60;
      weightMax = 200;
      weightController.text = '60';
      notifyListeners();
    }
  }

  //this function returns BMI group name
  String bmiGroup(double result) {
    if (result < 16.0) {
      return 'Wygłodzenie';
    }
    if (result >= 16 && result <= 17) {
      return 'Wychudzenie';
    }
    if (result >= 17 && result <= 18.5) {
      return 'Niedowaga';
    }
    if (result >= 18.5 && result <= 25) {
      return 'Waga prawidłowa';
    }
    if (result >= 25 && result <= 30) {
      return 'Nadwaga';
    }
    if (result >= 30 && result <= 35) {
      return 'Otyłość I stopnia';
    }
    if (result >= 35 && result <= 40) {
      return 'Otyłość II stopnia';
    }
    if (result >= 40) {
      return 'Otyłość III stopnia';
    }
    return '';
  }
}
