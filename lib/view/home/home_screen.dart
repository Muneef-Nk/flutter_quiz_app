import 'package:flutter/material.dart';
import '../../utils/database/database.dart';
import '../score/score_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}); // Fixed the constructor

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? ans;
  int? value;
  int Quescount = 0;
  int QuesNo = 0;
  int rAns = 0;

  List letter=["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: ,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ?",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "${QuesNo + 1}/10",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  DataBase.quizData[QuesNo]['question'],
                  style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          value = index;
                          value == DataBase.quizData[QuesNo]['answer']
                              ? rAns++
                              : print(value);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, top: 10, bottom: 10, right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color: Colors.black),
                            color: value == index
                                ? value ==
                                DataBase.quizData[QuesNo]['answer']
                                ? Colors.green
                                : Colors.red
                                : Colors.transparent
                          // Changed the comparison
                        ),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * .50,
                              child: Text(
                                DataBase.quizData[QuesNo]['options'][index],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: value == index
                                        ? Colors.white
                                        : Colors.black
                                        ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    QuesNo++;
                    value = 5;
                    Quescount++;

                    Quescount > 9
                        ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Score(ans: rAns),
                        ))
                        : SizedBox();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all()
                  ),
                  width: 150,
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
