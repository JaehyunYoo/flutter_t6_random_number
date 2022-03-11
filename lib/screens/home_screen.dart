import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number/constant/color.dart';
import 'package:random_number/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [123, 456, 789];
  int maxNumbers = 1000;
  void onRandomCreateNumber() {
    final rand = Random();
    final Set<int> numbers = {};
    while (numbers.length != 3) {
      numbers.add(rand.nextInt(maxNumbers));
    }
    setState(() {
      randomNumbers = numbers.toList();
    });
  }

  void onSettingsPop() async {
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (BuildContext context) {
        return Settings(
          maxNumber: maxNumbers,
        );
      }),
    );
    setState(() {
      if (result != null) {
        maxNumbers = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopPart(
                onPressed: onSettingsPop,
              ),
              _MiddlePart(randomNumbers: randomNumbers),
              _BottomPart(onPressed: onRandomCreateNumber)
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  final VoidCallback onPressed;
  const _BottomPart({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(primary: RED_COLOR),
        child: const Text('생성하기'),
      ),
    );
  }
}

class _MiddlePart extends StatelessWidget {
  const _MiddlePart({
    Key? key,
    required this.randomNumbers,
  }) : super(key: key);

  final List<int> randomNumbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumbers
              .asMap()
              .entries
              .map(
                (val) => Padding(
                  padding: EdgeInsets.only(bottom: val.key == 2 ? 0 : 16.0),
                  child: Row(
                      children: val.value
                          .toString()
                          .split('')
                          .map(
                            (v) => Image.asset(
                              'assets/images/$v.png',
                              width: 50,
                              height: 70,
                            ),
                          )
                          .toList()),
                ),
              )
              .toList()),
    );
  }
}

class _TopPart extends StatelessWidget {
  final VoidCallback onPressed;
  const _TopPart({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}
