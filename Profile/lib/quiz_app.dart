import 'package:flutter/material.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class Question {
  String q = '';
  bool? a;

  Question(String question, bool answer) {
    q = question;
    a = answer;
  }
}

class QuizBrain {
  List<Question> questions = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question(
        'Approximately one quarter of human bones are in the feet.', false),
    Question('A slugs blood is green.', true),
    Question('....Game Over...', true),
  ];
}

QuizBrain quizBrain = new QuizBrain();

class _QuizAppState extends State<QuizApp> {
  int i = 0;
  bool flag = false;
  List<Widget> score = [];

  @override
  Widget build(BuildContext context) {
    void checkanswer(bool userChoice) {
      setState(() {
        if (i < quizBrain.questions.length - 1) {
          i++;
          if (userChoice == quizBrain.questions[i].a) {
            score.add(Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
              ),
            ));
          } else {
            score.add(Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 30,
              ),
            ));
          }
        } else {
          i = 0;
          // await Future.delayed(Duration(seconds: 3));
          score.clear();
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black38,
        title: Text(
          "Quiz App",
          style: TextStyle(fontFamily: "ShortBaby", color: Colors.amber),
        ),
      ),
      body: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.min,

          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 70, bottom: 30, left: 20, right: 20),
                child: Center(
                  child: SizedBox(
                    height: 100, // Fixed height for the question text
                    child: Text(
                      quizBrain.questions[i].q,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'ShortBaby',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70, bottom: 30),
              child: MaterialButton(
                onPressed: () {
                  checkanswer(true);
                },
                child: Container(
                  width: 150,
                  height: 70,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green),
                  child: Center(
                    child: Text(
                      "True",
                      style: TextStyle(fontSize: 25, fontFamily: 'ShortBaby'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 100),
              child: MaterialButton(
                onPressed: () {
                  checkanswer(false);
                },
                child: Container(
                  width: 150,
                  height: 70,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.redAccent),
                  child: Center(
                    child: Text(
                      "False",
                      style: TextStyle(fontSize: 25, fontFamily: 'ShortBaby'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: score),
            ),
          ],
        ),
      ]),
    );
  }
}
