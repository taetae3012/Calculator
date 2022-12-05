import 'package:flutter/material.dart';

var inputVal = "0";
var inverse = false;
var operations = ["+", "-", "/","%","=","X"];
var dp = [false,false,false,false,false,false];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  update(String text,String type){
      if(inputVal == "0") {
        inputVal = "";
      }
      if(text == "AC"){
        setState(() {
          inputVal = "0";
          previous_value = 0;
        });
      } else if(type == "inverse"){
        if(inverse){
          setState(() {
            inputVal = inputVal.substring(1,inputVal.length);
            inverse = false;
          });

        } else{
          setState(() {
            inputVal = "-" + inputVal;
            inverse = true;
          });
        }
      } else if(!operations.contains(text) && text != "Back"){
        setState(() {
          inputVal += text;
        });
      }
  }
  num previous_value = 0;
  var operation = null;

  void compute(){
    var text = operation;
    String value = inputVal == "" ? "0" : inputVal;
    var current;
    current = double.parse(value);
    print(current);
    print(previous_value);
    print(operation);
    print("-=-----");

    if(text == "+" ){
      var res = (previous_value + current);
      inputVal = res.toString();
      previous_value = res;
      print(res);
    } else if(text == "X" ){
      var res  = (previous_value * current);
      inputVal = res.toString();
      previous_value = res;
      print(res);
    } else if(text == "-" ){
      var res  = (previous_value - current);
      inputVal = res.toString();
      previous_value = res;
      print(res);
    } else if(text == "/" ){
      var res  = (previous_value / current);
      inputVal = res.toString();
      previous_value = res;
      print(res);
    } else if(text == "%" ){
      var res  = (previous_value % current);
      inputVal = res.toString();
      previous_value = res;
      print(res);
    }
    print("=====");
  }
  bool isInteger(num value) => value is int || value == value.roundToDouble();
  String getAnswer(){
    if(isInteger(previous_value)){
      return previous_value.toInt().toString();
    } else{
      return previous_value.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget Btn(String text,{ String type = "None",Color color = Colors.black87,Color secondaryColor = Colors.white}){
      return Expanded(child: InkWell(
        onTap: (){
          if(text == "Back"){
            print("back");
            if(inputVal.length >= 2){
              var newString = inputVal.substring(0,inputVal.length - 1);
              setState(() {
                inputVal = newString;
              });
            } else if(inputVal.length == 1){
              setState(() {
                inputVal = "";
              });
            }

          }
          if(operations.contains(text)){
            var index = operations.indexOf(text);
            for(int i = 0; i< operations.length;i++){
              dp[i] = false;
            }
            setState(() {
              dp[index] = true;
            });
            if(text == "+" ){
              operation = "+";
            } else if(text == "X" ){
              operation = "X";
            } else if(text == "-" ){
              operation = "-";
            } else if(text == "/" ){
              operation = "/";
            } else if(text == "%" ){
              operation = "%";
            } else if(text == "="){
              compute();
              setState(() {
                dp[index] = false;
              });
            }
            String value = inputVal == "" ? "0" : inputVal;
            if(inputVal != ""){
              previous_value = double.parse(value);
            }

            inputVal = "";
          } else {
            update(text,type);
          }

        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: double.infinity,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black54, //New
                blurRadius: 10.0,
              )
            ],
          ),
          child: Center(child: text == "Back" ? Icon(Icons.backspace_rounded, color: Colors.white, size: 29,) :Text(text == "X" ? "x" : text,style: TextStyle(color: secondaryColor,fontSize: 29,fontWeight: FontWeight.bold),)),
        ),
      ));
    }
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(flex: 2,child: Container(color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AnimatedContainer(
                        duration: Duration(milliseconds:100),
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                        child: Text(getAnswer(),style: TextStyle(color: Colors.white,fontSize: 72,fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 40,top: 5),
                      child: Text(inputVal == "0" ? "" : inputVal,style: TextStyle(color: Colors.grey.shade600,fontSize: 32,fontWeight: FontWeight.bold),)),
                ],
              ),
            ],
          ),)),
          Expanded(flex: 3,child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, //New
                  blurRadius: 25.0,
                )
              ],
            ),
            padding: const EdgeInsets.only(left: 5,right: 5,bottom: 15,top: 10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Btn("AC", color: Colors.red,type: "AC",),
                      Btn("+/-",color: Colors.deepPurpleAccent,type: 'inverse'),
                      Btn("%",color: dp.elementAt(operations.indexOf("%")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("%")) ? Colors.black: Colors.white),
                      Btn("/", color:dp.elementAt(operations.indexOf("/")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("/")) ? Colors.black: Colors.white),
                    ],
                  ),
                ),
                Expanded(child: Row(
                  children: [
                    Btn("7",),
                    Btn("8",),
                    Btn("9",),
                    Btn("X",color: dp.elementAt(operations.indexOf("X")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("X")) ? Colors.black: Colors.white)
                  ],
                )),
                Expanded(child: Row(
                  children: [
                    Btn("4"),
                    Btn("5"),
                    Btn("6"),
                    Btn("-",color: dp.elementAt(operations.indexOf("-")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("-")) ? Colors.black: Colors.white)
                  ],
                )),
                Expanded(child: Row(
                  children: [
                    Btn("1",),
                    Btn("2"),
                    Btn("3"),
                    Btn("+",color: dp.elementAt(operations.indexOf("+")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("+")) ? Colors.black: Colors.white)
                  ],
                )),
                Expanded(child: Row(
                  children: [
                    Btn("0"),
                    Btn("."),
                    Btn("Back"),
                    Btn("=", color: dp.elementAt(operations.indexOf("=")) ? Colors.yellow : Colors.deepPurpleAccent,secondaryColor: dp.elementAt(operations.indexOf("=")) ? Colors.black: Colors.white)
                  ],
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}


