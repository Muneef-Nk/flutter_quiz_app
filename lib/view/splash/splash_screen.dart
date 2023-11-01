import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/utils/color_constants.dart';
import 'package:quiz_app/view/topics/topics_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => TopicsScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Lottie.asset("assets/animation/quizBulb.json"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Let's Play & Win",
            style: TextStyle(
                fontSize: 30, color: primary, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
