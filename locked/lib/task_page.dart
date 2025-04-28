import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'data/tasks.dart';
import 'models/task_collection.dart';
import 'fonts/font.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});

  final String title;

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  late TaskCollection currentTask;
  int currentTaskIndex = 0;

  List<int?> selectedAnswers = [
    null,
    null,
  ]; // Store selected answers for each task
  List<bool> feedbackShown = [
    false,
    false,
  ]; // Store feedback shown status for each task

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentTask = taskCollections[currentTaskIndex];

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
    final isCorrect =
        selectedAnswers[questionIndex] ==
        currentTask.questions[questionIndex].correctAnswerIndex;

    showDialog(
      context: context,
      builder:
          (_) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ), // Reduce the max width
              child: AlertDialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: const EdgeInsets.all(
                  20,
                ), // Adjust padding inside the dialog
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect ? 'Korrekt!' : 'Ikke helt rigtigt',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24, // Reduced font size for better fit
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Mycolors.dividerColor, thickness: 2),
                  ],
                ),
                content: Text(
                  'Korrekt svar: ${currentTask.questions[questionIndex].answers[currentTask.questions[questionIndex].correctAnswerIndex]}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16, // Reduced font size for better fit
                  ),
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
                    Container(
                      padding: const EdgeInsets.all(
                        18,
                      ), // Slightly increased padding
                      margin: const EdgeInsets.only(
                        top: 14,
                      ), // Slightly increased spacing
                      decoration: BoxDecoration(
                        color: Mycolors.barColor,
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Rounded corners
                      ),
                      child: Text(
                        currentTask.reflectionQuestion,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 20, // Slightly increased font size
                        ),
                        textAlign: TextAlign.left,
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
                            onPressed:
                                () => Navigator.pushNamed(context, '/ending'),
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


//To-do
// Scroll panel
// Variable to store the tasks + answers
// Number of the task
// Text that holds the task
// Text that holds the answers - letter for each option, answers should be clickable
// Function to check if the answer is correct
// Button to check the answer - available only after the answer is clicked
// On click - pop-up with the answer
// Text with scenario - bold
// Text with reflection 
// Button to go to the next page