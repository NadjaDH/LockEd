import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:locked/bluetooth.dart'; // Import the BluetoothConnection class
import 'data/tasks.dart';
import 'models/task_collection.dart';
import 'fonts/font.dart';
import 'styles/colors.dart';
import 'package:locked/ending_page.dart';

class TaskPage extends StatefulWidget {
  final String title;
  final BluetoothConnection bluetoothConnection;
  final int themeIndex; // Add themeIndex parameter

  const TaskPage({
    super.key,
    required this.title,
    required this.bluetoothConnection,
    required this.themeIndex,
  });

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  late TaskCollection currentTask;
  int currentTaskIndex = 0;

  List<int?> selectedAnswers = [];
  List<bool> feedbackShown = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentTask = taskCollections[widget.themeIndex];

    // Initialize answers and feedback lists dynamically
    selectedAnswers = List<int?>.filled(currentTask.questions.length, null);
    feedbackShown = List<bool>.filled(currentTask.questions.length, false);
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  void showFeedback(int questionIndex) {
    final selectedAnswerIndex = selectedAnswers[questionIndex];
    final isCorrect =
        selectedAnswerIndex ==
        currentTask.questions[questionIndex].correctAnswerIndex;

    final feedback =
        isCorrect
            ? currentTask.questions[questionIndex].correctFeedback
            : currentTask
                .questions[questionIndex]
                .feedback[selectedAnswerIndex! <
                    currentTask.questions[questionIndex].correctAnswerIndex
                ? selectedAnswerIndex
                : selectedAnswerIndex - 1];

    showDialog(
      context: context,
      builder:
          (_) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.all(20),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect ? 'Korrekt!' : 'Ikke helt rigtigt',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Mycolors.dividerColor, thickness: 2),
                  ],
                ),
                content: Text(
                  feedback, // Show feedback for the selected answer
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        feedbackShown[questionIndex] = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF388E3C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  bool get allAnswered =>
      selectedAnswers.every((a) => a != null) && feedbackShown.every((f) => f);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60, // Keep horizontal padding
              vertical: 60, // Ensure equal top and bottom padding
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 800, // Limit the width of elements
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int q = 0; q < currentTask.questions.length; q++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task number and question
                          Text(
                            'Spørgsmål ${q + 1}',
                            style: AppTextStyles.heading.copyWith(
                              fontSize:
                                  28, // Slightly increased font size for heading
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ), // Slightly increased spacing
                          Text(
                            currentTask.questions[q].question,
                            style: AppTextStyles.body.copyWith(
                              fontSize:
                                  20, // Slightly increased font size for body
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 18,
                          ), // Slightly increased spacing
                          // Answers
                          Column(
                            children: List.generate(4, (i) {
                              return Container(
                                margin: const EdgeInsets.only(
                                  bottom: 18,
                                ), // Slightly increased spacing
                                padding: const EdgeInsets.all(
                                  18,
                                ), // Slightly increased padding
                                decoration: BoxDecoration(
                                  color: Mycolors.barColor,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // Rounded corners
                                ),
                                child: InkWell(
                                  onTap: () => selectAnswer(q, i),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${String.fromCharCode(65 + i)}) ',
                                        style: AppTextStyles.body.copyWith(
                                          fontSize:
                                              20, // Slightly increased font size
                                          fontWeight: FontWeight.bold,
                                          color: Mycolors.textColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          currentTask.questions[q].answers[i],
                                          style: AppTextStyles.body.copyWith(
                                            fontSize:
                                                20, // Slightly increased font size
                                            fontWeight:
                                                selectedAnswers[q] == i
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),

                          const SizedBox(
                            height: 18,
                          ), // Slightly increased spacing
                          // Feedback button
                          if (selectedAnswers[q] != null && !feedbackShown[q])
                            ElevatedButton(
                              onPressed: () => showFeedback(q),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF388E3C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28, // Slightly increased padding
                                  vertical: 16, // Slightly increased padding
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // Rounded corners
                                ),
                                textStyle: const TextStyle(
                                  fontSize:
                                      20, // Slightly increased font size for button text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text('Check svar'),
                            ),

                          // Divider between questions
                          if (q < currentTask.questions.length - 1)
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: const Divider(
                                color: Mycolors.dividerColor,
                                thickness: 3,
                                height: 30, // Increased spacing
                              ),
                            ),
                        ],
                      ),

                    // Divider above "Bare til refleksion" heading
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: const Divider(
                        color: Mycolors.dividerColor,
                        thickness: 3,
                        height: 30, // Increased spacing
                      ),
                    ),

                    // "Bare til refleksion" heading
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Bare til refleksion',
                        style: AppTextStyles.heading.copyWith(
                          fontSize:
                              24, // Slightly increased font size for heading
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    const SizedBox(height: 18), // Slightly increased spacing
                    // Reflection Scenario (outside the box)
                    Text(
                      currentTask.reflectionScenario,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 20, // Slightly increased font size
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 14), // Slightly increased spacing
                    // Reflection Question (inside the box)
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 800, // Set the desired maximum width
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(
                          18, // Slightly increased padding
                        ),
                        margin: const EdgeInsets.only(
                          top: 14, // Slightly increased spacing
                        ),
                        decoration: BoxDecoration(
                          color: Mycolors.barColor,
                          borderRadius: BorderRadius.circular(
                            12, // Rounded corners
                          ),
                        ),
                        child: Text(
                          currentTask.reflectionQuestion,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 20, // Slightly increased font size
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24), // Slightly increased spacing
                    // Continue button
                    if (allAnswered)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 24.0, // Slightly increased padding
                            right: 7.0, // Increased padding
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Mycolors.buttonColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40, // Increased padding
                                vertical: 18, // Increased padding
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Rounded corners
                              ),
                              textStyle: const TextStyle(
                                fontSize:
                                    22, // Slightly increased font size for button text
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              widget.bluetoothConnection.sendCommand(
                                "close_servo",
                              );
                              setState(() {
                                currentTaskIndex +=
                                    1; // Increment the currentTaskIndex
                              });
                              developer.log(
                                'currentTaskIndex: $currentTaskIndex',
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EndingPage(
                                        title: 'Endingpage of LockEd',
                                        bluetoothConnection:
                                            widget.bluetoothConnection,
                                        themeIndex:
                                            widget
                                                .themeIndex, // Pass the existing instance
                                      ),
                                ),
                              ); // Navigate to the EndingPa// Navigate to the '/ending' route
                            },
                            child: const Text('Fortsæt'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
