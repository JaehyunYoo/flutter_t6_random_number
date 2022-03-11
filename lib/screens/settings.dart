import 'package:flutter/material.dart';
import 'package:random_number/constant/color.dart';

class Settings extends StatefulWidget {
  final int maxNumber;
  const Settings({Key? key, required this.maxNumber}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(
      maxNumber.toInt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _Body(maxNumber: maxNumber),
              _Footer(
                maxNumber: maxNumber,
                onChangedMaxNumber: onSliderChanged,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: maxNumber
            .toInt()
            .toString()
            .split('')
            .map(
              (e) => Image.asset(
                'assets/images/$e.png',
                width: 50,
                height: 70,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double> onChangedMaxNumber;
  final VoidCallback onButtonPressed;
  const _Footer({
    Key? key,
    required this.maxNumber,
    required this.onChangedMaxNumber,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onChangedMaxNumber,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
          child: Text('저장'),
        )
      ],
    );
  }
}
