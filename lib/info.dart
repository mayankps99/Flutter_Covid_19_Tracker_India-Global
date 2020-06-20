import 'util/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_screenutil/screenutil.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double screenHeight(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.height * percent;

  double screenWidth(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.width * percent;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
        backgroundColor: Color(0xff2C2B4B),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20*2.36.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    decoration: BoxDecoration(
                      color: Color(0xff1c1c2b),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,top: 10),
                          child: FadeAnimation(1
                            ,Text(
                              'Symptoms',
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 30*2.36.sp,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            FadeAnimation(1.1,
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/cough.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h,
                                  ),
                                  Text(
                                    'Cough',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.2,
                            Container(
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/fever.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h,
                                  ),
                                  Text(
                                    'Fever',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.3,
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/breath.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Dificulty in Breathing',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                          ],
                        ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FadeAnimation(1.4,
                              Container(
                                margin:
                                    EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                height: 130*2.36.w,
                                width: 130*2.36.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff1e1e30),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 60*2.36.w,
                                      width: 60*2.36.w,
                                      child: Image(
                                        image: AssetImage('assets/headache.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10*2.36.h
                                    ),
                                    Text(
                                      'Headache',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 18*2.36.sp,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),),
                              FadeAnimation(1.5,
                              Container(
                                height: 130*2.36.w,
                                width: 130*2.36.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff1e1e30),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 60*2.36.w,
                                      width: 60*2.36.w,
                                      child: Image(
                                        image: AssetImage('assets/throat.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10*2.36.h
                                    ),
                                    Text(
                                      'Sore Throat',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontSize: 18*2.36.sp,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20*2.36.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical:10),
                    decoration: BoxDecoration(
                      color: Color(0xff1c1c2b),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,top: 10),
                          child: FadeAnimation(1,
                          Text(
                            'Preventions',
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 30*2.36.sp,
                                color: whiteColor,
                                fontWeight: FontWeight.w600),
                          ),),
                        ),
                        Row(
                          children: <Widget>[
                            FadeAnimation(1.1,
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/stayhome.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Stay Home',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.2,
                            Container(
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/handwash.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Wash your hand for 20 sec',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.3,
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/handsanitizer.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Use Sanitizer',
                                    
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            FadeAnimation(1.4,
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/mask.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Wear Mask',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.5,
                            Container(
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/physical.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Maintain Distance',
                                    
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                            FadeAnimation(1.6,
                            Container(
                               margin:
                                  EdgeInsets.only(left: 10, right: 10),
                              height: 130*2.36.w,
                              width: 130*2.36.w,
                              decoration: BoxDecoration(
                                color: Color(0xff1e1e30),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 60*2.36.w,
                                    width: 60*2.36.w,
                                    child: Image(
                                      image: AssetImage('assets/social.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10*2.36.h
                                  ),
                                  Text(
                                    'Follow Social Distancing',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 18*2.36.sp,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
