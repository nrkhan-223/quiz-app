import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizeapp/screens/quiz_screen.dart';
import 'package:quizeapp/screens/start_screen.dart';

import '/widgets/next_button.dart';

class ResultScreen extends StatefulWidget {
  final int score;

  const ResultScreen({
    super.key,
    required this.score,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Your Score: ',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.score.toString(),
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 10),
            RectangularButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const StartScreen()),
                );

              },
              label: 'Return Home', focus: false,
            )
          ],
        ),
      ),
    );
  }
}
