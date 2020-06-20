import 'dart:async';
import 'package:covid19_tracker_demo/util/resource.dart';
import 'package:flutter/material.dart';
import 'main1.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));

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
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Color(0xff2C2B4B),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20*2.36.h,
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Center(
                child: FadeAnimation(
                  1,
                  Container(
                    width: ScreenUtil().setWidth(450 * 2.36),
                    height: ScreenUtil().setWidth(450 * 2.36),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(300 * 2.36),
                          height: ScreenUtil().setWidth(300 * 2.36),
                          child: Image.asset(
                            'assets/asset1.png',
                          ),
                        ),
                        Center(
                          child: Text(
                            'Covid-19',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 35*2.36.sp,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Tracker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 30*2.36.sp,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 250*2.36.w,
              height: 10*2.36.h,
              child: Center(
                child: LinearProgressIndicator(
                  backgroundColor: Color(0xff2C2B4B),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    whiteColor
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
