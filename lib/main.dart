import 'package:calculator/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var input = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      input = input + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 100,
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 170,
                            color: Colors.grey[500],
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    input,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  result,
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: backgroundGreyDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  height: 200,
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getRow('ac', 'ce', '%', '/'),
                      _getRow('7', '8', '9', '*'),
                      _getRow('4', '5', '6', '-'),
                      _getRow('1', '2', '3', '+'),
                      _getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: _getBackgroundColor(text1),
          ),
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                input = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          child: Text(
            text1,
            style: TextStyle(
              fontSize: 30,
              color: _GetTextColor(text1),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: _getBackgroundColor(text2),
          ),
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (input.length > 0) {
                  input = input.substring(0, input.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          child: Text(
            text2,
            style: TextStyle(
              fontSize: 30,
              color: _GetTextColor(text2),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: _getBackgroundColor(text3),
          ),
          onPressed: () {
            buttonPressed(text3);
          },
          child: Text(
            text3,
            style: TextStyle(
              fontSize: 30,
              color: _GetTextColor(text3),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
            backgroundColor: _getBackgroundColor(text4),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(input);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          child: Text(
            text4,
            style: TextStyle(
              fontSize: 30,
              color: _GetTextColor(text4),
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var List = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in List) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color _getBackgroundColor(String text) {
    if (isOperator(text)) {
      return backgroundGreyDark;
    } else {
      return backgroundGrey;
    }
  }

  Color _GetTextColor(String text) {
    if (isOperator(text)) {
      return textGreen;
    } else {
      return textGrey;
    }
  }
}
