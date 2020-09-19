import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:silly_hacks/providers/app_provider.dart';
import 'package:silly_hacks/screens/silly_rock_paper_kabutar.dart';
import 'package:silly_hacks/screens/silly_wallpaper_generator.dart';
import 'package:silly_hacks/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Utils.appDocsDir = await getApplicationDocumentsDirectory();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
      ],
      child: SillyApps(),
    ),
  );
}

class SillyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, appProvider, __) => MaterialApp(
        theme: ThemeData(
          primaryColor: appProvider.primaryColor,
          primaryColorDark: appProvider.primaryColor,
          accentColor: appProvider.accentColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SillyAppsHome(),
          '/silly_wallpaper_generator': (context) => SillyWallpaperGenerator(),
          '/silly_rock_paper_kabutar': (context) => SillyRockPaperKabutar(),
        },
      ),
    );
  }
}

class SillyAppsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Silly Apps'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/silly_wallpaper_generator');
            },
            trailing: Text(
              Demoji.framed_picture,
              style: TextStyle(fontSize: 30),
            ),
            title: Text('Silly Wallpaper Generator'),
            subtitle: Text('How to: Click FAB or Shake Device'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/silly_rock_paper_kabutar');
            },
            trailing: Text(
              Demoji.bird,
              style: TextStyle(fontSize: 30),
            ),
            title: Text('Silly Rock Paper Kabutar'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
