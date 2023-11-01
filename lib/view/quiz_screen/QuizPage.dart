import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/db/database.dart';
import 'package:quiz_app/utils/color_constants.dart';
import 'package:quiz_app/view/score/score_screen.dart';
import 'package:quiz_app/view/topics/topics_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List letter = ["A", "B", "C", "D"];

  List questions = [];
  int qNo = 0;
  late bool isCorrect;
  int? correctIndex;
  int? selectedIndex;
  bool isSeleted = false;
  int score = 0;
  bool noTap = false;

  checkAnswer(int index) {
    List optionslist = questions[qNo]["options"];
    String correct = questions[qNo]["correct"];

    setState(() {
      selectedIndex = index;
    });
    for (String i in optionslist) {
      if (i == correct) {
        setState(() {
          correctIndex = optionslist.indexOf(i);
        });
      }
    }

    if (correctIndex == index) {
      setState(() {
        isCorrect = true;
        score += 1;
      });
    } else {
      setState(() {
        isCorrect = false;
      });
    }

    Future.delayed(Duration(seconds: 2)).then((value) {
      nextQustion();
      print(score);
    });
    setState(() {
      isSeleted = true;
    });
    print(isCorrect);
  }

  nextQustion() {
    isSeleted = false;
    if (qNo < questions.length - 1) {
      setState(() {
        qNo += 1;
        noTap = false;
        selectedIndex = null;
        correctIndex = null;
      });
    } else if (qNo == questions.length - 1) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Score(
                ans: score,
              )));
    }
  }

  isSelectedAnswer() {
    if (selectedIndex == 0 ||
        selectedIndex == 1 ||
        selectedIndex == 2 ||
        selectedIndex == 3) {
      setState(() {
        noTap = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    questions = Questions.quizedList[Questions.quizlistIndex];
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              //

              showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: primary,
                    insetPadding: EdgeInsets.zero,
                    // contentTextStyle: GoogleFonts.mulish(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Quit Quiz?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Are you sure you want exit!',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => TopicsScreen()),
                              (route) => false);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: ,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Time remaining",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Countdown(
                      seconds: 200,
                      build: (BuildContext context, double time) => Text(
                        time.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      interval: Duration(seconds: 1),
                      onFinished: () {
                        // goto score
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Score(ans: score)));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: LinearTimer(
                  duration: const Duration(seconds: 200),
                  color: Colors.pink,
                  backgroundColor: Colors.white,
                  onTimerEnd: () {
                    print("timer ended");
                  },
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question ?",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${qNo + 1}/10",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    questions[qNo]["question"],
                    style: TextStyle(
                        fontSize: 18, height: 1.5, color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Select your answer!",
                    style: TextStyle(
                        fontSize: 12, height: 1.5, color: Colors.greenAccent),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                isSeleted
                    ? Lottie.asset("assets/animation/loading3.json", width: 30)
                    : Text(""),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (noTap == false) {
                              setState(() {
                                noTap = true;
                                checkAnswer(index);
                              });
                            } else {
                              null;
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: 200,
                            height: 70,
                            decoration: BoxDecoration(
                                color: index == correctIndex && isCorrect
                                    ? Colors.green
                                    : index == selectedIndex && !isCorrect
                                        ? Colors.red
                                        : primaryLight,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 6),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.black,
                                    child: Text(
                                      letter[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                    width: 250,
                                    child: Text(
                                      questions[qNo]["options"][index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: selectedIndex == index
                                              ? questions[qNo]['answer'] ==
                                                      selectedIndex
                                                  ? Colors.white
                                                  : Colors.white
                                              : Colors.white),
                                      textAlign: TextAlign.left,
                                    )),
                                Visibility(
                                  visible: selectedIndex == index
                                      ? questions[qNo]['answer'] ==
                                              selectedIndex
                                          ? true
                                          : true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: Colors.white,
                                        child:
                                            index == correctIndex && isCorrect
                                                ? Icon(
                                                    Icons.check,
                                                    color: Colors.black,
                                                  )
                                                : index == selectedIndex &&
                                                        !isCorrect
                                                    ? Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      )
                                                    : Text('')),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
