import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List <String> buttonList = [
    'AC', 'V', 'C', 'x', '/', '(', ')', '%', '*', '1', '2',
    '3', '-', '4', '5', '6', '+', '7', '8', '9', '0', '00', '.', '=',
  ];
  static const Color backgroundColor1 = Color(000000);
  static const Color textWhite = Color(0xffB6BCC1);
  static const Color buttonColor = Color(0xFF64B5F6);
  static const Color equalButton = Color(0xff96a0a8);
  static const Color AC = Color(0xffFF3535);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // children: [
      //
      // ],
      backgroundColor: backgroundColor1,
      body: Column(
        children: [
            Text('Calculator', style: TextStyle(
              color: textWhite,
              fontSize: 30,
            ),
            ),
        SizedBox(
          height: MediaQuery.of(context).size.height/5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                userInput,
                style: TextStyle(
                fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: textWhite,
              ),
              ),
            ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: textWhite,
                  ),
                ),
              ),
          ],),
        ),
          // Divider(
          //   color: buttonColor
          // ),
          Expanded(child: Container(
            width: 500,
            // height: 500,
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: buttonList.length,
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
                itemBuilder: (BuildContext context, int index){
              return CalculatorButton(buttonList[index]);
            },
            ),
          ),
          ),
      ],
      ),
    );
  }
  Widget CalculatorButton(String text){
    if (text == "="){
      return InkWell(

        // splashColor: buttonColor,
        onTap: (){
          setState(() {
            handleButtons(text);
          });
        },
        // child: Container(
        //   width: 200,
        //
        // )
        child: Ink(
          decoration: BoxDecoration(

            color: getBgColor(text),
          ),
          child: Center(
            child: Text(
              // padding: EdgeInsets.all(10),
              text,
              style: TextStyle(
                color: textWhite,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    };
    return InkWell(
      splashColor: buttonColor,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
        ),
        child: Center(
          child: Text(
            // padding: EdgeInsets.all(10),
            text,
            style: TextStyle(
              color: textWhite,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  getBgColor(String text){
    if(text == "="){
      return Color(0xff1379c2);
    }
    if(text == "AC"){
      return Color(0xff0B344F);
    }
    else{
      return Color(0xff0B344F);
    }
  }

  handleButtons(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }

    if(text == "="){
      result = calculate();
      userInput = result;

      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }

  String calculate(){
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }

}
