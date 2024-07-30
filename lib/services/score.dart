class Score {
  final String level;
  int totalQuestions; // اجعلها غير نهائية
  int correctAnswers; // اجعلها غير نهائية

  Score({
    required this.level,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  // يمكن أن تحتوي على طرق أخرى إذا لزم الأمر
  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
    };
  }
}
