class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String score;
  final String? questionImageUrl;

  Question({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
    this.questionImageUrl,
    required this.score,
  });
}
