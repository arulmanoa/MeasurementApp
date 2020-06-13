
import 'package:flutter/material.dart';
import './calculation.dart';
import './splashscreen.dart';


var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => CalculationPage(),
};

// final routes = <String, WidgetBuilder>{
//     CalculationPage.tag: (context) => CalculationPage(),
   
//   };

void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: Colors.deepPurple, accentColor: Colors.yellowAccent),
    home: SplashScreen(),
    routes: routes));