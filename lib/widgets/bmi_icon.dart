import 'package:flutter/material.dart';

class BmiIcon extends StatelessWidget {
  double result;

  BmiIcon(this.result);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(result < 10 ? Icons.check_box : Icons.stop),
    );
  }
}
