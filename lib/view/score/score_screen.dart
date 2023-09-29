import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../home/home_screen.dart';

class Score extends StatelessWidget {
  const Score({super.key, required this.ans});
  final int ans;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Column(
              children: [
                Text(
                  "Score",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),

                new CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: ans/10,
                  center: new Text("$ans/10", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  progressColor: Colors.green,
                  backgroundColor: Colors.red,
                ),

                SizedBox(height: 20,),
                Text(
                  "Correct Answers : $ans",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Wrong Answers : ${10 - ans}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                width: 150,
                child: Center(
                  child: Text(
                    "Try Again",
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
            SizedBox()
          ],
        ),
      ),
    );
  }
}
