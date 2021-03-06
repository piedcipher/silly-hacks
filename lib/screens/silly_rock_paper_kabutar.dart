import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shake/shake.dart';
import 'package:silly_hacks/utils/utils.dart';
import 'package:vibration/vibration.dart';

class SillyRockPaperKabutar extends StatefulWidget {
  @override
  _SillyRockPaperKabutarState createState() => _SillyRockPaperKabutarState();
}

class _SillyRockPaperKabutarState extends State<SillyRockPaperKabutar> {
  bool _computerRock = true;
  bool _computerPaper = true;
  bool _computerKabutar = true;

  bool _playerRock = true;
  bool _playerPaper = true;
  bool _playerKabutar = true;

  List<String> _computerMoves = [Demoji.moyai, Demoji.newspaper, Demoji.bird];
  List<String> _playerMoves = [Demoji.moyai, Demoji.newspaper, Demoji.bird];

  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        Vibration.vibrate();
        if (_playerMoves.length == 1 && _computerMoves.length == 1) return;
        _playerMoves.shuffle();
        _computerMoves.shuffle();
        setState(() {
          switch (_playerMoves.removeLast()) {
            case Demoji.moyai:
              _playerRock = false;
              break;
            case Demoji.newspaper:
              _playerPaper = false;
              break;
            case Demoji.bird:
              _playerKabutar = false;
              break;
          }
          switch (_computerMoves.removeLast()) {
            case Demoji.moyai:
              _computerRock = false;
              break;
            case Demoji.newspaper:
              _computerPaper = false;
              break;
            case Demoji.bird:
              _computerKabutar = false;
              break;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Utils.sharedPreferences.getBool(Utils.sillyRockPaperKabutarInfoKey) ==
            null ||
        !Utils.sharedPreferences.getBool(Utils.sillyRockPaperKabutarInfoKey)) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        await Utils.sharedPreferences
            .setBool(Utils.sillyRockPaperKabutarInfoKey, true);
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Rules ${Demoji.unamused}'),
            content: _HowToGuide(),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('K'),
              ),
            ],
          ),
        );
      });
    }
    if (_playerMoves.length == 1 && _computerMoves.length == 1) {
      String result = '';
      if ((_playerMoves[0] == Demoji.moyai &&
              _computerMoves[0] == Demoji.moyai) ||
          (_playerMoves[0] == Demoji.newspaper &&
              _computerMoves[0] == Demoji.newspaper) ||
          (_playerMoves[0] == Demoji.bird &&
              _computerMoves[0] == Demoji.bird)) {
        // Tie
        result = 'Tie';
      } else if ((_computerMoves[0] == Demoji.newspaper &&
              _playerMoves[0] == Demoji.moyai) ||
          (_computerMoves[0] == Demoji.bird &&
              _playerMoves[0] == Demoji.newspaper) ||
          (_computerMoves[0] == Demoji.moyai &&
              _computerMoves[0] == Demoji.bird)) {
        // Computer Wins
        result = 'Computer Wins';
      } else if ((_playerMoves[0] == Demoji.newspaper &&
              _computerMoves[0] == Demoji.moyai) ||
          (_playerMoves[0] == Demoji.bird &&
              _computerMoves[0] == Demoji.newspaper) ||
          (_playerMoves[0] == Demoji.moyai &&
              _computerMoves[0] == Demoji.bird)) {
        // Player Wins
        result = 'You Win';
      }
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(
              result,
              textAlign: TextAlign.center,
            ),
            content: Table(
              children: [
                TableRow(
                  children: [
                    Text(
                      'You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Computer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        _playerMoves[0],
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        _computerMoves[0],
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  setState(() {
                    _computerPaper = true;
                    _computerRock = true;
                    _computerKabutar = true;
                    _playerPaper = true;
                    _playerRock = true;
                    _playerKabutar = true;
                    _playerMoves = [
                      Demoji.moyai,
                      Demoji.newspaper,
                      Demoji.bird
                    ];
                    _computerMoves = [
                      Demoji.moyai,
                      Demoji.newspaper,
                      Demoji.bird
                    ];
                  });
                  Navigator.pop(context);
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        );
      });
    }
    return GestureDetector(
      onLongPress: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Rules ${Demoji.unamused}'),
            content: _HowToGuide(),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('K'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: AppBar(
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Center(
                      child: Text(
                        '${Demoji.man_technologist}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
                leading: Center(
                  child: Text(
                    '${Demoji.man_technologist}',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'Computer',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.moyai,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _computerRock ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: ClipRRect(
                              child: Container(
                                child: Text(
                                  Demoji.newspaper,
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _computerPaper ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.bird,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _computerKabutar ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.moyai,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _playerRock ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: ClipRRect(
                              child: Container(
                                child: Text(
                                  Demoji.newspaper,
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _playerPaper ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.bird,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _playerKabutar ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              child: Text(
                                Demoji.x,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: AppBar(
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Center(
                      child: Text(
                        '${Demoji.sunglasses}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
                leading: Center(
                  child: Text(
                    '${Demoji.sunglasses}',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  'You',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HowToGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Text('- Each player has 3 moves.\n\n'
          '- Shaking the phone will randomly remove 1 move from each player.\n\n'
          '- After 2 shakes winner is decided.\n\n'
          '- Last move of each player is used to determine the winner.\n\n'
          '   - ${Demoji.moyai} v/s ${Demoji.newspaper} = ${Demoji.newspaper}\n\n'
          '   - ${Demoji.newspaper} v/s ${Demoji.bird} = ${Demoji.bird}\n\n'
          '   - ${Demoji.bird} v/s ${Demoji.moyai} = ${Demoji.moyai}\n\n'
          '- Tap and Hold anywhere here to view this again.'),
    );
  }
}
