import 'package:google_nav_bar/google_nav_bar.dart';
import 'util/margin.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'india.dart';
import 'global.dart';
import 'newsInfo.dart';

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
      children: <Widget>[
        HomeScreen(),
        GlobalScreen(),
        NewScreen(),
//Info Page
      ],
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff348A7B),
          boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight:Radius.circular(30.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const YMargin(60),
                      Text(
                        'Covid-19',
                        style: GoogleFonts.cabin(
                          textStyle:
                              TextStyle(fontSize: 21, color: Colors.white),
                        ),
                      ),
                      const YMargin(4),
                      Text(
                        'Tracker',
                        style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              fontSize: 27,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Image.asset('assets/asset2.png',width: 120,height: 120,),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const YMargin(10),
            Expanded(child: buildPageView()),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color(0xff348A7B), 
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10)
                .add(EdgeInsets.only(top: 5)),
            child: GNav(
                gap: 1,
                activeColor: Colors.white,
                color: Colors.grey[400],
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'India',
                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                    backgroundColor: Colors.red,
                  ),
                  GButton(
                    icon: LineIcons.globe,
                    text: 'Global',
                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                    backgroundColor: Colors.red,
                  ),
                  GButton(
                    icon: LineIcons.newspaper_o,
                    text: 'News',
                    textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
                    backgroundColor: Colors.red,
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  if (!mounted) return;
                  setState(() {
                    pageController.jumpToPage(index);
                  });
                }),
          ),
        ),
      ),
    );
  }
}
