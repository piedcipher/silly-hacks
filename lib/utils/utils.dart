import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Utils {
  static SharedPreferences sharedPreferences;
  static const String sillyWallPaperGeneratorInfoKey =
      'sillyWallPaperGeneratorKey';
  static const String sillyRockPaperKabutarInfoKey =
      'sillyRockPaperKabutarInfoKey';
  static final Random randomInstance = Random();
  static final ScreenshotController screenshotController =
      ScreenshotController();
  static final List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.center,
    Alignment.centerLeft,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];
  static Directory appDocsDir;

  static MaterialColor get randomPrimaryColor =>
      Colors.primaries[Utils.randomInstance.nextInt(Colors.primaries.length)];

  static MaterialAccentColor get randomAccentColor =>
      Colors.accents[Utils.randomInstance.nextInt(Colors.accents.length)];
}
