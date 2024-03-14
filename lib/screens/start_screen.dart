import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizeapp/screens/quiz_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/next_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharePref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Padding(
        padding: EdgeInsets.only(left: 18.0),
        child: Text('Quiz App'),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Height Score:',style: TextStyle(fontSize: 30,color: Colors.white),),
              const SizedBox(
                width: 10,
              ),
              pref.getInt("Score")==null? const Text("0",style: TextStyle(fontSize: 30,color: Colors.white)):
              Text(pref.getInt("Score").toString(),style: const TextStyle(fontSize: 30,color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Your Score:',style: TextStyle(fontSize: 20)),
              const SizedBox(
                width: 10,
              ),
              Text(scor.toString(),style: const TextStyle(fontSize: 20)),
            ],
          ),
          RectangularButton(
            onPressed: () {
              scor = 0;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              );
            },
            label: 'Start', focus: false,
          )
        ],
      ),
    );
  }
}
