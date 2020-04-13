import 'dart:async';
import 'package:flutter/material.dart';
import 'main1.dart';
import 'Animation/FadeAnimation.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen()));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainScreen())));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff348A7B),
      body: Stack(
                    children: <Widget>[
                      Center(
                        child: FadeAnimation(1,Image.asset('assets/asset1.png',width: 350,height: 350,),),
                      )
                    ],
                  ),
    );
  }
}