import 'util/margin.dart';
import 'util/resource.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'india.dart';
import 'developer.dart';
import 'global.dart';
import 'info.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[HomeScreen(), GlobalScreen(), InfoScreen()],
    );
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    if (!mounted) return;
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff2C2B4B),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(20 * 2.36),
                          ),
                          Text(
                            'Covid-19',
                            style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: ScreenUtil().setSp(22 * 2.36),
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Text(
                            'Tracker',
                            style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: ScreenUtil().setSp(30 * 2.36),
                                  color: whiteColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 40*2.36.w,
                          width: 40*2.36.w,
                          child: Image(
                            image: AssetImage('assets/programmer.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const YMargin(10),
              Expanded(child: buildPageView()),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff2C2B4B),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.home,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'India',
                style: TextStyle(fontSize: 20, fontFamily: 'Proxima Nova'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.globe,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Global',
                style: TextStyle(fontSize: 20, fontFamily: 'Proxima Nova'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.info,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Info',
                style: TextStyle(fontSize: 20, fontFamily: 'Proxima Nova'),
              ),
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          onTap: (index) {
            if (!mounted) return;
            setState(() {
              pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext){
        return DeveloperScreen();
      }
    );
  }
}
