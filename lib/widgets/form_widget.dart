import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bmi_provider.dart';

class FormWidget extends StatefulWidget {
  BuildContext ctx;

  FormWidget(this.ctx);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BmiProvider>(widget.ctx).heightController.text = '160';
    Provider.of<BmiProvider>(widget.ctx).weightController.text = '60';
  }

  //check if value contains more than 2 dots
  bool validateDots(String x) {
    int dotsCount = 0;
    x.split('').forEach((element) {
      if (element.contains('.')) dotsCount += 1;
    });
    if (dotsCount >= 2) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BmiProvider>(context);
    return Form(
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
                            value.contains(RegExp(
                                r'[a-zA-Z!@#$%^&*()\-_,?":{}|<>+=~`]')) ||
                            value.startsWith('.') ||
                            validateDots(
                                value) || //check if value contains more than 2 dots
                            value.contains(' ') ||
                            double.parse(value) > data.heightMax ||
                            value.length > 6) {
                          return '';
                        }
                      },
                      controller: data.heightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onChanged: (value) {
                        if (_formKey.currentState!.validate()) {
                          data.setHeightValue(double.parse(value));
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
                          child: const Text('cm',
                              style: TextStyle(color: Colors.white)),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: const Text(
                            'ft',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: 1,
                        ),
                      ],
                      value: data.heightUnit,
                      onChanged: (value) {
                        data.dropdownCallBackHeight(value);
                      }),
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
                            value.contains(RegExp(
                                r'[a-zA-Z!@#$%^&*()\-_,?":{}|<>+=~`]')) ||
                            value.contains(' ') ||
                            validateDots(
                                value) || //check if value contains more than 2 dots
                            value.startsWith('.') ||
                            double.parse(value) > data.weightMax ||
                            value.length > 6) {
                          return '';
                        }
                      },
                      controller: data.weightController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (value) {
                        if (_formKey.currentState!.validate()) {
                          data.setWeightValue(double.parse(value));
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
                          child:
                              Text('kg', style: TextStyle(color: Colors.white)),
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
                      value: data.weightUnit,
                      onChanged: (value) {
                        data.dropdownCallBackWeight(value);
                      }),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
