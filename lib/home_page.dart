import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> questionsAndOptions = [
    {
      'question': 'Which is the highest building in the world?',
      'options': [
        'China Zun',
        'Lakhta Center',
        'Burj Khalifa',
        'Jin Mao Tower'
      ],
      'answerIndex': 2
    },
    {
      'question': 'Which is the longest river in the world?',
      'options': ['The Nile', 'Amazon River', 'Uele River', 'Mississippi'],
      'answerIndex': 0
    },
    {
      'question': 'Which is the hardest language in the world?',
      'options': ['Arabic', 'Mandarin', 'Japanese', 'Turkish'],
      'answerIndex': 1
    }
  ];

  int currentQuestionIdx = 0;
  int score = 0;
  int currentAnswerIdx = -1;
  bool displayResult = false;
  double progressBarValue = 0.3;
  bool anOptionIsClilcked =
      false; //becomes true when an option is clicked, and will be reset for each question

  void storeAnswer(int answerIdx) {
    currentAnswerIdx = answerIdx;
    anOptionIsClilcked = true; //the user clicked an option
  }

  void displayNextQuestion(int questionIdx) {
    //the user choose an an answer
    if (anOptionIsClilcked == true) {
      //check if the user's answer for the current question is correct
      if (currentAnswerIdx == questionsAndOptions[questionIdx]['answerIndex']) {
        score++;
        print(score);
      }

      //if the user didn't finish the quiz, move to next question
      if (questionIdx != 2) {
        currentQuestionIdx++;
        currentAnswerIdx =
            -1; //to make the color of all options of the new question gray
      } else {
        //the user finished the quiz
        displayResult = true;
      }

      progressBarValue += 0.3;
      anOptionIsClilcked = false; //reset for the next question
    }
  }

  void redoQuiz() {
    currentQuestionIdx = 0;
    score = 0;
    currentAnswerIdx = -1;
    displayResult = false;
    progressBarValue = 0.3;
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questionsAndOptions[currentQuestionIdx];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: progressBarValue,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              backgroundColor: Colors.white,
              minHeight: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${currentQuestionIdx + 1}/3',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            if (displayResult == false) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  currentQuestion['question'],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 28.0,
              ),
              for (int i = 0; i < currentQuestion['options'].length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 6.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          storeAnswer(i);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: i == currentAnswerIdx
                                ? Colors.green
                                : Colors.white,
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.circle,
                                    size: 10,
                                    color: i == currentAnswerIdx
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                currentQuestion['options'][i],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: i == currentAnswerIdx
                                        ? Colors.white
                                        : Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0)),
                    ),
                    onPressed: () {
                      //the user clicks next without choosing an option
                      if (anOptionIsClilcked == false) {
                        const snackBar = SnackBar(
                          content: Text('You have to choose an answer!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        //the user clicks next after choosing an option
                        setState(() {
                          displayNextQuestion(currentQuestionIdx);
                        });
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (score >= 2) ...[
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 38),
                      ),
                    ] else ...[
                      const Text(
                        'Oops!',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 38),
                      ),
                    ],
                    Text(
                      'Your score is $score',
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          setState(redoQuiz);
                        },
                        child: const Text('Redo quiz'))
                  ],
                ),
              )
            ],
         
          ],
        ),
      ),
    );
  }
}
