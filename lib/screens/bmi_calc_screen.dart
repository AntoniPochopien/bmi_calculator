import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/bmi_icon.dart';

class BmiCalc extends StatefulWidget {
  const BmiCalc({super.key});

  @override
  State<BmiCalc> createState() => _BmiCalcState();
}

class _BmiCalcState extends State<BmiCalc> {
  final _formKey = GlobalKey<FormState>();
  double heightValue = 160;
  double weightValue = 60;
  double heightMax = 250.00;
  double weightMax = 200.00;
  int heightUnit = 0;
  int weightUnit = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //initialy set textFileds to default visual value
    weightController.text = '60';
    heightController.text = '160';
  }

  //function that returns BMI result in double datatype, also convert units to meters and kilograms.

  //if you want to add other measurement unit, you have to convert it using if statement as below
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

  //dropdownbutton function which controlls height measurement units. Change sliders maxvalue depend on selected unit
  void dropdownCallBackHeight(int? unit) {
    if (unit == 1) {
      setState(() {
        heightUnit = 1;
        heightValue = 5;
        heightMax = 8;
        heightController.text = '5';
      });
    } else {
      setState(() {
        heightUnit = 0;
        heightValue = 160;
        heightMax = 250;
        heightController.text = '160';
      });
    }
  }

  //dropdownbutton function which controlls weight measurement units. Change sliders maxvalue depend on selected unit
  void dropdownCallBackWeight(int? unit) {
    if (unit == 1) {
      setState(() {
        weightUnit = 1;
        weightValue = 120;
        weightMax = 400;
        weightController.text = '120';
      });
    } else {
      setState(() {
        weightUnit = 0;
        weightValue = 60;
        weightMax = 200;
        weightController.text = '60';
      });
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: screenSize.height * 1,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                const Text(
                  'Twoje BMI:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Text(
                  '${bmiResult(heightValue, weightValue)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Text(
                  bmiGroup(bmiResult(heightValue, weightValue)),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                SizedBox(
                  height: screenSize.height * 0.55,
                  child: Row(
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: BmiIcon(
                          bmiResult(heightValue, weightValue),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: heightValue,
                            min: 0,
                            max: heightMax,
                            onChanged: (value) => setState(() {
                              heightValue =
                                  double.parse(value.toStringAsFixed(2));
                              heightController.text = value.toStringAsFixed(2);
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Slider(
                  value: weightValue,
                  min: 0,
                  max: weightMax,
                  onChanged: (value) => setState(() {
                    weightValue = double.parse(value.toStringAsFixed(2));
                    weightController.text = value.toStringAsFixed(2);
                  }),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const Expanded(flex: 2, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp('^[0-9.]+').hasMatch(value) ||
                                        value.contains(RegExp(
                                            r'[a-zA-Z!@#$%^&*()\-_,?":{}|<>+=~`]')) ||
                                        double.parse(value) > heightMax ||
                                        value.length > 6) {
                                      return '';
                                    }
                                  },
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(height: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() =>
                                          heightValue = double.parse(value));
                                    }
                                  }),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                dropdownColor: Colors.grey[700],
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('cm',
                                        style: TextStyle(color: Colors.white)),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'ft',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 1,
                                  ),
                                ],
                                value: heightUnit,
                                onChanged: (value) =>
                                    dropdownCallBackHeight(value),
                              ),
                            ),
                            const Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const Expanded(flex: 2, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp('^[0-9.]+').hasMatch(value) ||
                                        value.contains(RegExp(
                                            r'[a-zA-Z!@#$%^&*()\-_,?":{}|<>+=~`]')) ||
                                        value.startsWith('.') ||
                                        double.parse(value) > weightMax ||
                                        value.length > 6) {
                                      return '';
                                    }
                                  },
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(height: 0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onChanged: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() =>
                                          weightValue = double.parse(value));
                                    }
                                  }),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                dropdownColor: Colors.grey[700],
                                items: const [
                                  DropdownMenuItem(
                                    child: Text('kg',
                                        style: TextStyle(color: Colors.white)),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'lb',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 1,
                                  ),
                                ],
                                value: weightUnit,
                                onChanged: (value) =>
                                    dropdownCallBackWeight(value),
                              ),
                            ),
                            const Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
