import 'package:flutter/material.dart';
import '../../utils/database/database.dart';
import '../score/score_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}); // Fixed the constructor

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List letter=["A", "B", "C", "D"];

  int qNo=0;
  int? selectedIndex;
  int ans =0;
  bool isSelected=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              setState(() {
                if (qNo>0) {
                  qNo--;
                }
              });
            },
            child:qNo>0? Icon(Icons.arrow_back, color: Colors.black,):Text("")),
      ),
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
                  Text("${qNo+1}/10", style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800]
                  ),)

                ],
              ),
              SizedBox(height: 15),
              Center(
                child: Text(DataBase.quizData[qNo]["question"],
                  // DataBase.quizData[QuesNo]['question'],
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
                height: 300,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                    itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex=index;
                          isSelected =true;
                          selectedIndex== DataBase.quizData[qNo]['answer'] ?ans++:null;
                        });
                      },
                      child:Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectedIndex==index ? DataBase.quizData[qNo]['answer'] == selectedIndex? Colors.green:Colors.red:Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black,
                                child: Text(letter[index], style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                                width: 250,
                                child: Text(DataBase.quizData[qNo]["options"][index], style: TextStyle(fontSize: 15,color: selectedIndex==index ? DataBase.quizData[qNo]['answer'] == selectedIndex? Colors.white:Colors.white:Colors.black ),textAlign: TextAlign.left, )
                            ),
                            Visibility(
                              visible:selectedIndex==index ? DataBase.quizData[qNo]['answer'] == selectedIndex? true:true:false,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:Colors.white,
                                child:selectedIndex==index ? DataBase.quizData[qNo]['answer'] == selectedIndex? Icon(Icons.check, color: Colors.black,):Icon(Icons.close, color: Colors.black,):null),
                            )
                          ],
                        ),
                      ),
                    );
                    }
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  setState(() {
                      selectedIndex=5;
                      if(DataBase.quizData.length-1>qNo){
                        qNo++;
                      }else{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Score(ans: ans,)));
                      }
                  });



                },
                child:Visibility(
                  visible: selectedIndex == 0 || selectedIndex ==1 || selectedIndex==2|| selectedIndex==3?true:false,
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                    ),
                    child: Center(child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
