import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        Vibration.vibrate();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, appProvider, __) => Scaffold(
        appBar: AppBar(
          title: Text('Silly Wallpaper Generator'),
          actions: [
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
              icon: Icon(
                Icons.share,
                semanticLabel: 'Share Wallpaper',
              ),
            ),
          ],
        ),
        body: Center(
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
        floatingActionButton: FloatingActionButton(
          child: Text(
            Demoji.smirk,
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            appProvider.primaryColor = Utils.randomPrimaryColor;
            appProvider.accentColor = Utils.randomAccentColor;
          },
        ),
      ),
    );
  }
}
