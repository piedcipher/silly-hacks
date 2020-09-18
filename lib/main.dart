import 'dart:math';
import 'dart:ui';

import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SillyCounter());
}

class SillyCounter extends StatefulWidget {
  @override
  _SillyCounterState createState() => _SillyCounterState();
}

class _SillyCounterState extends State<SillyCounter> {
  double _sillyCount = 69;
  MaterialColor _primaryColor = Colors.blue;
  MaterialAccentColor _accentColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _primaryColor,
        primaryColorDark: _primaryColor,
        accentColor: _accentColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Silly Counter'),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: SweepGradient(
                colors: [_primaryColor, _accentColor],
                center: Alignment.bottomRight,
                startAngle: 69,
                endAngle: 100,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _sillyCount.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(
            Demoji.smirk,
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            setState(() {
              final randomInstance = Random();
              final randomNumber = randomInstance.nextDouble();

              _primaryColor = Colors
                  .primaries[randomInstance.nextInt(Colors.primaries.length)];
              _accentColor =
                  Colors.accents[randomInstance.nextInt(Colors.accents.length)];

              if (randomNumber.toString().contains('1'))
                _sillyCount += randomNumber;
              if (randomNumber.toString().contains('2'))
                _sillyCount -= randomNumber;
              if (randomNumber.toString().contains('3'))
                _sillyCount *= randomNumber;
              if (randomNumber.toString().contains('4') && randomNumber != 0)
                _sillyCount /= randomNumber;
            });
          },
        ),
      ),
    );
  }
}
