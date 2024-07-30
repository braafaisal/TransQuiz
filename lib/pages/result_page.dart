import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  ResultsScreen({required this.totalQuestions, required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    int incorrectAnswers = totalQuestions - correctAnswers;
    double percentage = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('نتائج المستوى'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildResultRow(
                  'Total Questions', totalQuestions.toString(), Colors.blue),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildResultRow(
                  'Correct Answers', correctAnswers.toString(), Colors.green),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildResultRow(
                  'Wrong Attempts', incorrectAnswers.toString(), Colors.red),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildResultRow(
                'Success Percentage',
                '$percentage%',
                percentage >= 50 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Back to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
