import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // استيراد مكتبة تحويل النص إلى كلام
import 'package:spell_it/pages/result_page.dart';
import 'package:spell_it/services/score.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<Map<String, String>> questions = [];
  String level = '';
  List<dynamic> gameScoreList = [];
  late Score gameScore;
  Function? onLevelComplete;

  int currentQuestionIndex = 0;
  TextEditingController answerController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts(); // كائن لتحويل النص إلى كلام

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    questions = (arguments['questions'] as List<dynamic>?)
            ?.map((item) => Map<String, String>.from(item as Map))
            .toList() ??
        [];
    level = arguments['level'] ?? '';
    gameScoreList = arguments['gameScoreList'] ?? [];
    gameScore = arguments['gameScore'] ??
        Score(level: level, totalQuestions: 0, correctAnswers: 0);
    onLevelComplete = arguments['onLevelComplete'] as Function?;

    _flutterTts.setLanguage("en-US"); // تعيين اللغة إلى الإنجليزية
    if (currentQuestionIndex < questions.length - 1) {
      _speakWord(questions[currentQuestionIndex]['en'] ?? '');
    }
  }

  void _speakWord(String word) async {
    await _flutterTts.speak(word);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _checkAnswer() {
    String correctAnswer = questions[currentQuestionIndex]['en'] ?? '';
    String userAnswer = answerController.text.trim().toLowerCase();

    if (userAnswer == correctAnswer) {
      setState(() {
        gameScore.correctAnswers += 1;
      });
    }
    setState(() {
      gameScore.totalQuestions += 1;
    });

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex += 1;
        answerController.clear();
        _speakWord(questions[currentQuestionIndex]['en'] ?? '');
      });
    } else {
      _completeLevel();
    }
  }

  void _completeLevel() {
    if (onLevelComplete != null) {
      onLevelComplete!(gameScore.totalQuestions, gameScore.correctAnswers);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          totalQuestions: gameScore.totalQuestions,
          correctAnswers: gameScore.correctAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex]['ar'] ?? '',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  _speakWord(questions[currentQuestionIndex]['en'] ?? ''),
              child: Text('Read Word'),
            ),
            TextField(
              style: TextStyle(color: Colors.pink, fontSize: 30),
              controller: answerController,
              decoration: InputDecoration(
                labelText: 'أدخل إجابتك',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('تحقق من الإجابة'),
            ),
          ],
        ),
      ),
    );
  }
}
