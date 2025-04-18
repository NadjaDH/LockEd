import 'package:flutter/material.dart';
import 'package:locked/styles/colors.dart';
import 'data/tasks.dart';
import 'models/task_collection.dart';
//import 'fonts/font.dart';

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
          (_) => AlertDialog(
            backgroundColor:
                Theme.of(
                  context,
                ).scaffoldBackgroundColor, // Use theme background color
            title: Text(
              isCorrect ? 'Korrekt!' : 'Ikke helt rigtigt',
              style:
                  Theme.of(
                    context,
                  ).textTheme.titleLarge, // Use theme-defined title style
            ),
            content: Text(
              'Korrekt svar: ${currentTask.questions[questionIndex].answers[currentTask.questions[questionIndex].correctAnswerIndex]}',
              style:
                  Theme.of(
                    context,
                  ).textTheme.bodyMedium, // Use theme-defined body text style
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    feedbackShown[questionIndex] =
                        true; // Mark feedback as shown
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF388E3C,
                  ), // Use the custom button color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ), // Increase padding for a larger button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20, // Increase font size for larger text
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'DM Sans', // Replace with your custom font family name
                  ),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  bool get allAnswered =>
      selectedAnswers.every((a) => a != null) && feedbackShown.every((f) => f);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(
            context,
          ).scaffoldBackgroundColor, // Use theme background color
      body: Scrollbar(
        thumbVisibility: true, // Show scrollbar
        child: SingleChildScrollView(
          // Make the panel scrollable
          child: Padding(
            padding: const EdgeInsets.all(60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int q = 0; q < currentTask.questions.length; q++)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20.0,
                    ), // Add spacing between tasks
                    padding: const EdgeInsets.all(
                      16.0,
                    ), // Inner padding for the box
                    decoration: BoxDecoration(
                      color:
                          Colors
                              .transparent, // Make the box background transparent
                      border: Border.all(
                        color: Colors.black.withOpacity(
                          0.4,
                        ), // Border color with transparency
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          blurRadius: 8, // Blur radius for the shadow
                          offset: const Offset(0, 4), // Offset for the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task number and question
                        Text(
                          'Spørgsmål ${q + 1}',
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .titleLarge, // Use theme-defined heading style
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentTask.questions[q].question,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontStyle:
                                FontStyle.italic, // Make the text cursive
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Answers
                        Column(
                          children: List.generate(4, (i) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:
                                    () => selectAnswer(
                                      q,
                                      i,
                                    ), // Update the selected answer
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Bold letter (a), (b), etc.
                                    Text(
                                      '${String.fromCharCode(97 + i)}) ', // Generate a), b), c), d)
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontWeight:
                                            FontWeight
                                                .bold, // Make the letter bold
                                      ),
                                    ),
                                    // Regular answer text
                                    Flexible(
                                      child: Text(
                                        currentTask.questions[q].answers[i],
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.copyWith(
                                          fontWeight:
                                              selectedAnswers[q] == i
                                                  ? FontWeight.bold
                                                  : FontWeight
                                                      .normal, // Highlight selected answer
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 10),

                        // Feedback button
                        if (selectedAnswers[q] != null && !feedbackShown[q])
                          ElevatedButton(
                            onPressed:
                                () => showFeedback(q), // Show feedback dialog
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF388E3C,
                              ), // Use the custom button color
                              foregroundColor: Colors.white, // Text color
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ), // Adjust padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Rounded corners
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20, // Adjust size for the button text
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    'DM Sans', // Replace with your custom font family name
                              ),
                            ),
                            child: const Text('Check svar'),
                          ),
                      ],
                    ),
                  ),
                // Add a thin white line
                const Divider(
                  color: Colors.white, // Set the color of the line to white
                  thickness: 1, // Set the thickness of the line
                  height: 40, // Add spacing above and below the line
                ),

                // "Bare til refleksion" heading
                Center(
                  child: Text(
                    'Bare til refleksion', // Heading text
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold, // Make the heading bold
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), // Add spacing between the heading and the reflection box
                // Reflection box
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                  ), // Add spacing above the box
                  padding: const EdgeInsets.all(
                    16.0,
                  ), // Inner padding for the box
                  decoration: BoxDecoration(
                    color:
                        Colors
                            .transparent, // Make the box background transparent
                    border: Border.all(
                      color: Colors.black.withOpacity(
                        0.4,
                      ), // Border color with transparency
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 8, // Blur radius for the shadow
                        offset: const Offset(0, 4), // Offset for the shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center horizontally
                      children: [
                        Text(
                          currentTask.reflectionScenario,
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .titleLarge, // Use theme-defined heading style
                          textAlign: TextAlign.center, // Center-align the text
                        ),
                        const SizedBox(
                          height: 10,
                        ), // Add spacing between the texts
                        Text(
                          currentTask.reflectionQuestion,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontStyle:
                                FontStyle.italic, // Make the text cursive
                          ),
                          textAlign: TextAlign.center, // Center-align the text
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                if (allAnswered)
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Mycolors.buttonColor, // Use the custom button color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ), // Adjust padding for a larger button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Rounded corners
                        ),
                        textStyle: const TextStyle(
                          fontSize:
                              25, // Use the font size from the button font
                          fontWeight: FontWeight.bold, // Use bold text
                          fontFamily: 'DM Sans', // Use the custom font family
                        ),
                      ),
                      onPressed:
                          () => Navigator.pushNamed(
                            context,
                            '/ending',
                          ), // Navigate to the ending page
                      child: const Text('Fortsæt'),
                    ),
                  ),
              ],
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