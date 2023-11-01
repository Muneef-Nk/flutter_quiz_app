import 'package:flutter/material.dart';
import 'package:quiz_app/db/database.dart';
import 'package:quiz_app/view/quiz_screen/QuizPage.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  List topics = [
    "Python",
    "Flutter",
    "Dot net",
    "MEARN",
    "Aptitude",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff242D4A),
        appBar: AppBar(
          backgroundColor: Color(0xff242D4A),
          elevation: 0,
          centerTitle: true,
          title: Text("Topics"),
        ),
        body: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Questions.quizlistIndex = index;
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => QuizPage()));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Color.fromARGB(255, 68, 79, 115),
                  child: ListTile(
                    title: Text(
                      topics[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }));
  }
}
