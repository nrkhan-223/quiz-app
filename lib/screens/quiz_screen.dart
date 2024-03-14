import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quizeapp/screens/start_screen.dart';

import '../main.dart';
import '/models/questions.dart';
import '/widgets/answer_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

int scor = 0;

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    startTime();
    // TODO: implement initState
    super.initState();
  }

  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  int counter = 10;
  late Timer timer;

  saveValue() {
    pref.setInt("Score", score);

    log(pref.get("Score").toString());
  }

  void startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        if (mounted) {
          setState(() {
            counter--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  void pickAnswer(int value) {
    timer.cancel();
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score = score + int.parse(question.score);
      scor = scor + int.parse(question.score);
    }
    if (mounted) setState(() {});
  }

  void last() {
    timer.cancel();
    if (pref.getInt("Score")?.toInt() == null) {
      saveValue();
    }
    if (score.toInt() > pref.getInt("Score")!.toInt()) {
      saveValue();
    }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StartScreen()),
      );
    });
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
    var index = questionIndex + 1;
    if (mounted) {
      setState(() {
        if (counter == 0) {
          isLastQuestion ? last() : goToNextQuestion();
          timer.cancel();
          counter = 10;
          startTime();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Quiz App',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(width: 17),
            Text(
              "Progress: $index/${questions.length}",
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            Text(
              "TIme: ${counter.toString()} s",
              style: const TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 21,
                ),
                textAlign: TextAlign.center,
              ),
              if (question.questionImageUrl!.isNotEmpty)
                Image.network(
                  question.questionImageUrl.toString(),
                  width: 200,
                ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: selectedAnswerIndex == null
                        ? () {
                            pickAnswer(index);
                            Future.delayed(const Duration(seconds: 3), () {
                              isLastQuestion ? last() : goToNextQuestion();
                              counter = 10;
                              startTime();
                            });
                          }
                        : null,
                    child: AnswerCard(
                      currentIndex: index,
                      question: question.options[index],
                      isSelected: selectedAnswerIndex == index,
                      selectedAnswerIndex: selectedAnswerIndex,
                      correctAnswerIndex: question.correctAnswerIndex,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
