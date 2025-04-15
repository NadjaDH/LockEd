import 'package:flutter/material.dart';
import 'data/tasks.dart';
import 'models/task_collection.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});

  final String title;

  @override
  State<TaskPage> createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  late TaskCollection currentTask;
  int currentTaskIndex = 0;

  List<int?> selectedAnswers = [null, null]; // Store selected answers for each task
  List<bool> feedbackShown = [false, false]; // Store feedback shown status for each task
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentTask = taskCollections[currentTaskIndex];
  }

  void selectAnswer (int questionIndex, int answerIndex) { 
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  void showFeedback(int questionIndex) {
    final isCorrect = selectedAnswers[questionIndex] == currentTask.questions[questionIndex].correctAnswerIndex;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Korrekt!' : 'Ikke helt rigtigt'),
        content: Text(
          'Korrekt svar: ${currentTask.questions[questionIndex].answers[currentTask.questions[questionIndex].correctAnswerIndex]}'
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                feedbackShown[questionIndex] = true; // Mark feedback as shown
              });
            },
            child: const Text('OK'),
          ),
        ],
      )
    );
  }

  bool get allAnswered => selectedAnswers.every((a) => a != null) && 
                            feedbackShown.every((f) => f);


  @override 
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(241, 241, 241, 1.0),
      // TO-DO: Add a scrollable panel
      child: Scrollbar(
        thumbVisibility: true, // Show scrollbar
        child: SingleChildScrollView( // Make the panel scrollable
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int q = 0; q < currentTask.questions.length; q++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Task number and question
                      Text(
                  'Opgave ${q + 1}',
                        style: const TextStyle(color: Colors.black87, fontFamily: 'DM sans', fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentTask.questions[q].question,
                        style: const TextStyle(color: Colors.green, fontFamily: 'DM sans', fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

      // Answers
                      Column(
                        children: List.generate(4, (i) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(         
                              onTap: () => selectAnswer(q, i),
                              child: Row(
                                children: [
                                  Text(
                                    '${String.fromCharCode(97 + i)}) ',
                                    style: const TextStyle(color: Colors.green, fontFamily: 'DM sans'),
                                  ),
                                  Flexible(
                                    child: Text(
                                      currentTask.questions[q].answers[i],
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'DM sans',
                                        fontWeight: selectedAnswers[q] == i ? FontWeight.bold : FontWeight.normal,
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

                      if (selectedAnswers[q] != null && !feedbackShown[q])
                        ElevatedButton(
                          onPressed: () => showFeedback(q),
                          child: const Text('Check svar'),
                        ),

                      const Divider(height: 30),
                    ],
                  ),


                Text(
                  currentTask.reflectionScenario,
                  style: const TextStyle(color: Colors.green, fontFamily: 'DM sans', fontWeight: FontWeight.bold),
                ),

                Text(
                  currentTask.reflectionQuestion,
                  style: const TextStyle(color: Colors.green, fontFamily: 'DM sans'),
                ),

                if (allAnswered)
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/ending'), // Navigate to the ending page
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