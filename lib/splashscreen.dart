import 'dart:async';

import 'package:flutter/material.dart';
import 'package:first_app/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     
                       Image.asset(
                        'assets/images/splash.png',
                        width: 350,
                        height: 350,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor:  AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 9.0),
                      
                    ),
                    
                    Text(
                      "Loading...",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                       
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
