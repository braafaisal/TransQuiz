import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spell_it/components/game_screen.dart';
import 'package:spell_it/services/game_data.dart';
import 'package:spell_it/services/score.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/game') {
            final Map<String, dynamic> args =
                settings.arguments as Map<String, dynamic>;

            return MaterialPageRoute(
              builder: (context) {
                return Game();
              },
            );
          }
          return null;
        },
      ),
    );

class Level {
  final String name;
  final int number;
  final Color color;

  Level({required this.name, required this.number, required this.color});
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Level> levels = [
    Level(name: 'المستوى 1', number: 1, color: Colors.blue),
    Level(name: 'المستوى 2', number: 2, color: Colors.green),
    Level(name: 'المستوى 3', number: 3, color: Colors.red),
  ];

  List<bool> levelUnlocked = [true, false, false];
  List<dynamic> gameScoreList = [];
  late Score gameScore;

  @override
  void initState() {
    super.initState();
    _loadLevelUnlockedStatus();

    _loadScores();
  }

  Future<void> _loadLevelUnlockedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? levelStatus = prefs.getStringList('levelUnlocked');
    if (levelStatus != null) {
      setState(() {
        levelUnlocked = levelStatus.map((e) => e == 'true').toList();
      });
    } else {
      setState(() {
        levelUnlocked = [true, false, false];
      });
    }
    _resetLevelState();
  }

  Future<void> _loadScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gameScoreList = [];
    for (var level in levels) {
      String? jsonString = prefs.getString(level.name);
      if (jsonString != null) {
        List<dynamic> scores = jsonDecode(jsonString);
        gameScoreList.addAll(scores);
      }
    }
  }

  void _goToGame(BuildContext context, Level level) async {
    if (!levelUnlocked[level.number - 1]) {
      _showLevelLockedDialog(context);
      return;
    }

    GameData gameData = GameData(levelName: level.name);
    await gameData.getQuestions();

    if (gameData.questions == null || gameData.questions!.isEmpty) {
      _showInvalidQuestionDialog(context);
      return;
    }

    gameScore = Score(level: level.name, totalQuestions: 0, correctAnswers: 0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Game(),
        settings: RouteSettings(arguments: {
          'questions': gameData.questions,
          'level': level.name,
          'gameScoreList': gameScoreList,
          'gameScore': gameScore,
          'onLevelComplete': _handleLevelCompletion,
        }),
      ),
    );
  }

  void _handleLevelCompletion(int totalQuestions, int correctAnswers) async {
    double percentage = (correctAnswers / totalQuestions) * 100;
    int currentLevelIndex = levels.indexWhere((l) => l.name == gameScore.level);

    if (percentage >= 90 && currentLevelIndex + 1 == levels.length) {
      // إعادة تعيين المستويات إلى الحالة الافتراضية
      _resetLevelsToDefault();
      _showLevelUnlockedDialog(context);
    } else if (percentage >= 90 && currentLevelIndex + 1 < levels.length) {
      setState(() {
        levelUnlocked[currentLevelIndex + 1] = true;
      });
      await _saveLevelUnlockedStatus();
      _showLevelUnlockedDialog(context);
    } else {
      _showIncompleteLevelDialog(context);
    }
  }

  void _resetLevelsToDefault() async {
    setState(() {
      levelUnlocked = [true, false, false];
    });
    await _saveLevelUnlockedStatus();
  }

  Future<void> _saveLevelUnlockedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'levelUnlocked', levelUnlocked.map((e) => e.toString()).toList());
  }

  void _resetLevelState() {
    setState(() {
      levelUnlocked = [true, false, false];
    });
  }

  void _showLevelLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("المستوى مقفل"),
          content: Text("قم بإكمال المستويات السابقة لفتح هذا المستوى."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  void _showLevelUnlockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("مبرووك!"),
          content: Text("تم فتح مستوى جديد!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  void _showIncompleteLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("المستوى لم يكتمل"),
          content: Text("لم تكمل المستوى بنجاح كافٍ لفتح المستوى التالي."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  void _showInvalidQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("خطأ في تحميل الأسئلة"),
          content: Text("لا توجد أسئلة متاحة لهذا المستوى."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("حسناً"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text('Spell It'),
          actions: [
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.blue,
                  size: 40,
                ),
                onPressed: _resetLevelState,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  radius: 100.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: levels[index].color,
                        child: ListTile(
                          title: Text(levels[index].name),
                          trailing: levelUnlocked[index]
                              ? Icon(Icons.lock_open, color: Colors.white)
                              : Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 25,
                                ),
                          onTap: () => _goToGame(context, levels[index]),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
