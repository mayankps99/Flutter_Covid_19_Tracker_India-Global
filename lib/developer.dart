import 'package:covid19_tracker_demo/util/margin.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'util/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Animation/FadeAnimation.dart';
import 'dart:async';
import 'package:flutter_screenutil/screenutil.dart';
import 'main1.dart';

class DeveloperScreen extends StatefulWidget {
  @override
  _DeveloperScreenState createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  Future<void> _launchLinkedin() async {
  const url = 'https://www.linkedin.com/in/mayank-singh-876474149/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  Future<void> _launchGitHub() async {
  const url = 'https://github.com/mayankps99';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<void> _launchFacebook() async {
  const url = 'https://www.facebook.com/mayank.jcjhs';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<void> _launchMail() async {
  const url = 'mailto:novabytee@gmail.com?subject= &body= %20plugin';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Container(
      height: 288*2.36.h,
      child: Stack(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff1c1c2b),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50 * 2.36.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              FadeAnimation(
                                1,
                                Center(
                                  child: Container(
                                    height: 150*2.36.w,
                                    width: 150*2.36.w,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/profile.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: FadeAnimation(1.1,Text(
                                      'Mayank Singh',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 25*2.36.sp,
                                        color: fontLight,
                                      ),
                                    ),),
                                  ),
                                  SizedBox(
                                    height: 10 * 2.36.h,
                                  ),
                                  Center(
                                    child: FadeAnimation(1.3,Text(
                                      'Flutter & Full Stack Dev',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 20*2.36.sp,
                                        color: fontMedium,
                                      ),
                                    ),),
                                  ),
                                  SizedBox(
                                    height: 10 * 2.36.h,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      FadeAnimation(1.1,IconButton(
                                        onPressed: _launchLinkedin,
                                        icon: Icon(
                                          LineIcons.linkedin,
                                          color: Color(0xff0073B1),
                                          size: 40 * 2.36.sp,
                                        ),
                                      ),),
                                      FadeAnimation(1.2,
                                      IconButton(
                                        onPressed: _launchGitHub,
                                        icon: Icon(
                                          LineIcons.github,
                                          color: Color(0xff5C6BC0),
                                          size: 40 * 2.36.sp,
                                        ),
                                      ),),
                                      FadeAnimation(1.3,
                                      IconButton(
                                        onPressed: _launchFacebook,
                                        icon: Icon(
                                          LineIcons.facebook_square,
                                          color: Color(0xff3B5998),
                                          size: 40 * 2.36.sp,
                                        ),
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10 * 2.36.h,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      FadeAnimation(1.1,Icon(
                                        Icons.mail_outline,
                                        color: Color(0xff5C6BC0),
                                        size: 40 * 2.36.sp,
                                      ),),
                                      FadeAnimation(1.3,InkWell(
                                        onTap: _launchMail,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'novabytee@gmail.com',
                                            style: TextStyle(
                                              fontFamily: fontFamily,
                                              fontSize: 18 * 2.36.sp,
                                              color: fontLight,
                                            ),
                                          ),
                                        ),
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50 * 2.36.h,
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ]),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 30*2.36.w,
                height: 30*2.36.w,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: Icon(
                    Icons.close,color: whiteColor,
                    size: 20*2.36.sp,
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
