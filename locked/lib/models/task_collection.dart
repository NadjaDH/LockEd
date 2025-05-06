class TaskCollection {
  final String theme;
  final List<TaskQuestion> questions;
  final String reflectionScenario;
  final String reflectionQuestion;

  TaskCollection({
    required this.theme,
    required this.questions,
    required this.reflectionScenario,
    required this.reflectionQuestion,
  });
}

class TaskQuestion {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final String correctFeedback; // Non-nullable
  final List<String> feedback;

  TaskQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    required this.correctFeedback, // Non-nullable
    required this.feedback,
  });
}
