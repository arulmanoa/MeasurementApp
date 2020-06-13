import 'package:first_app/calculation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  void navigateUrl() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalculationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('there',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(180.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                  Container(
                      height: 50.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.deepPurple,
                        color: Colors.deepPurple,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: navigateUrl,
                           
                          child: Center(
                            child: Text(
                              'Click here to Go!',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ''),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                )),
            SizedBox(height: 65.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  ' Measurement Application ',
                  style: TextStyle(
                     
                      fontSize: 16.0,
                      letterSpacing: 2),
                ),
                SizedBox(width: 5.0),
              ],
            )
          ],
        ));
   
  }
}
