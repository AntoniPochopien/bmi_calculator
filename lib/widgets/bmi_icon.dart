import 'package:flutter/material.dart';

class BmiIcon extends StatelessWidget {
  double result;
  BmiIcon(this.result);

  @override
  Widget build(BuildContext context) {
    Widget iconBuilder(double value) {
      if (result < 16.0) {
        return Image.asset(
          'assets/skeleton.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 16 && result <= 17) {
        return Image.asset(
          'assets/skinny.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 17 && result <= 18.5) {
        return Image.asset(
          'assets/skinny.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 18.5 && result <= 25) {
        return Image.asset(
          'assets/normal.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 25 && result <= 30) {
        return Image.asset(
          'assets/normal.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 30 && result <= 35) {
        return Image.asset(
          'assets/huge.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 35 && result <= 40) {
        return Image.asset(
          'assets/extraHuge.png',
          height: 300,
          width: 300,
        );
      }
      if (result >= 40) {
        return Image.asset(
          'assets/extremeHuge.png',
          height: 300,
          width: 300,
        );
      }
      return Icon(Icons.apple_outlined);
    }

    return Center(
      child: iconBuilder(result),
    );
  }
}
