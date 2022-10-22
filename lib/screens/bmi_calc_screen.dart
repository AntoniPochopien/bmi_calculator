import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bmi_icon_widget.dart';
import '../widgets/form_widget.dart';
import '../providers/bmi_provider.dart';

class BmiCalc extends StatefulWidget {
  const BmiCalc({super.key});

  @override
  State<BmiCalc> createState() => _BmiCalcState();
}

class _BmiCalcState extends State<BmiCalc> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BmiProvider>(context);
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
                  '${data.bmiResult(data.heightValue, data.weightValue)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Text(
                  data.bmiGroup(
                      data.bmiResult(data.heightValue, data.weightValue)),
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
                          data.bmiResult(data.heightValue, data.weightValue),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: data.heightValue,
                            min: 0,
                            max: data.heightMax,
                            onChanged: (value) => setState(() {
                              data.heightValue =
                                  double.parse(value.toStringAsFixed(2));
                              data.heightController.text =
                                  value.toStringAsFixed(2);
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Slider(
                  value: data.weightValue,
                  min: 0,
                  max: data.weightMax,
                  onChanged: (value) => setState(() {
                    data.weightValue = double.parse(value.toStringAsFixed(2));
                    data.weightController.text = value.toStringAsFixed(2);
                  }),
                ),
                FormWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
