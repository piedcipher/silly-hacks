import 'dart:async';

import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shake/shake.dart';
import 'package:share_extend/share_extend.dart';
import 'package:silly_hacks/providers/app_provider.dart';
import 'package:silly_hacks/utils/utils.dart';
import 'package:vibration/vibration.dart';

class SillyWallpaperGenerator extends StatefulWidget {
  @override
  _SillyWallpaperGeneratorState createState() =>
      _SillyWallpaperGeneratorState();
}

class _SillyWallpaperGeneratorState extends State<SillyWallpaperGenerator> {
  StreamController<bool> _showAlertOnVibrate;
  bool _shouldDestroy = false;

  @override
  void initState() {
    super.initState();
    _showAlertOnVibrate = StreamController<bool>.broadcast();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        Vibration.vibrate();
        setState(() {});
        _showAlertOnVibrate.add(true);
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          await Future.delayed(Duration(milliseconds: 500),
              () => _showAlertOnVibrate.add(false));
        });
      },
    );
  }

  @override
  void dispose() {
    _showAlertOnVibrate.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, appProvider, __) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Wallpaper Generator'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _shouldDestroy = true;
                });
              },
              tooltip: 'Wallpaper Destroyer',
              icon: Text(
                Demoji.smirk,
                style: TextStyle(fontSize: 24),
                semanticsLabel: 'Wallpaper Destroyer',
              ),
            ),
            IconButton(
              onPressed: () async {
                final wallpaper = await Utils.screenshotController.capture(
                  path: p.join(Utils.appDocsDir.path,
                      '${DateTime.now().millisecondsSinceEpoch.toString()}.png'),
                  pixelRatio: 1.5,
                  delay: Duration(milliseconds: 100),
                );
                await ShareExtend.share(wallpaper.path, 'image');
              },
              tooltip: 'Share Wallpaper',
              icon: Icon(
                Icons.share,
                semanticLabel: 'Share Wallpaper',
              ),
            ),
          ],
        ),
        body: Center(
          child: AnimatedOpacity(
            curve: Curves.bounceInOut,
            onEnd: () {
              setState(() {
                _shouldDestroy = false;
              });
            },
            duration: Duration(seconds: _shouldDestroy ? 2 : 0),
            opacity: _shouldDestroy ? 0 : 1,
            child: Screenshot(
              controller: Utils.screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Utils.randomPrimaryColor,
                      Utils.randomAccentColor,
                      appProvider.primaryColor,
                      appProvider.accentColor,
                      Utils.randomPrimaryColor,
                      Utils.randomAccentColor,
                    ],
                    begin: Utils.alignments[
                        Utils.randomInstance.nextInt(Utils.alignments.length)],
                    end: Utils.alignments[
                        Utils.randomInstance.nextInt(Utils.alignments.length)],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: _showAlertOnVibrate.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return FloatingActionButton.extended(
                icon: Icon(Icons.vibration),
                label: Text(
                  'Vibrating',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  appProvider.primaryColor = Utils.randomPrimaryColor;
                  appProvider.accentColor = Utils.randomAccentColor;
                },
              );
            }
            return FloatingActionButton(
              child: Text(
                Demoji.smirk,
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                appProvider.primaryColor = Utils.randomPrimaryColor;
                appProvider.accentColor = Utils.randomAccentColor;
              },
            );
          },
        ),
      ),
    );
  }
}
