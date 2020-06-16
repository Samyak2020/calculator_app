import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String equation = '0';
  String result = '0';
  String exp = '';
  double eqFontSize = 36.0;
  double resultFontSize = 46.0;

  btnPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
        eqFontSize = 36.0;
        resultFontSize = 46.0;
      } else if (btnText == '⌫') {
        eqFontSize = 46.0;
        resultFontSize = 36.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
          eqFontSize = 36.0;
          resultFontSize = 46.0;
        }
      } else if (btnText == '=') {
        eqFontSize = 36.0;
        resultFontSize = 46.0;

        exp = equation;
        exp = exp.replaceAll('×', '*');
        exp = exp.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression expression = p.parse(exp);
          ContextModel cm = ContextModel();
          result = '${expression.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        eqFontSize = 46.0;
        resultFontSize = 36.0;
        if (equation == '0') {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget buildButton(String btnText, double btnHeight, Color btnColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11 * btnHeight,
      color: btnColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
              color: Colors.white30, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 26.0,
              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
        onPressed: () => btnPressed(btnText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: eqFontSize,
                  color: Colors.red,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(child: Divider()),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: resultFontSize,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            //Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton('AC', 1, Colors.red),
                        buildButton('⌫', 1, Colors.red),
                        buildButton('÷', 1, Colors.blue[800]),
                      ]),
                      TableRow(children: [
                        buildButton('7', 1, Colors.white10),
                        buildButton('8', 1, Colors.white10),
                        buildButton('9', 1, Colors.white10),
                      ]),
                      TableRow(children: [
                        buildButton('4', 1, Colors.white10),
                        buildButton('5', 1, Colors.white10),
                        buildButton('6', 1, Colors.white10),
                      ]),
                      TableRow(children: [
                        buildButton('1', 1, Colors.white10),
                        buildButton('2', 1, Colors.white10),
                        buildButton('3', 1, Colors.white10),
                      ]),
                      TableRow(children: [
                        buildButton('.', 1, Colors.white10),
                        buildButton('0', 1, Colors.white10),
                        buildButton('00', 1, Colors.white10),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton('×', 1, Colors.blue[800]),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('+', 1, Colors.blue[800]),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('⁻', 1, Colors.blue[800]),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton('=', 2, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
