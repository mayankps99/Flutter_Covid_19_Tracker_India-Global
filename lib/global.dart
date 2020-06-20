import 'package:covid19_tracker_demo/util/card.dart';
import 'util/resource.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_screenutil/screenutil.dart';

class GlobalScreen extends StatefulWidget {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  double borderRadius = 0.0;

  int totalConfirmed, totalRecovered, totalDeaths;
  int totalNewCases, totalNewDeaths, totalActiveCases;
  getData() async {
    print("Start");
    var res = await http.get(
        "http://api.coronatracker.com/v3/stats/worldometer/global",
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    if (!mounted) return;
    setState(() {
      totalConfirmed = resBody['totalConfirmed'];
      totalRecovered = resBody['totalRecovered'];
      totalDeaths = resBody['totalDeaths'];
      totalActiveCases = resBody['totalActiveCases'];
      totalNewCases = resBody['totalNewCases'];
      totalNewDeaths = resBody['totalNewDeaths'];
    });
  }

  List<States> stateList = List<States>();
  List<States> temp = List();
  int count = 1;
  void getDetails() async {
    var res = await http
        .get("https://api.coronatracker.com/v3/stats/worldometer/topCountry");
    var resBody = json.decode(res.body);

    for (var s in resBody) {
      States temp1 = States(
          count,
          s["country"].toString(),
          s["totalConfirmed"].toString(),
          s["totalRecovered"].toString(),
          s["totalDeaths"].toString());
      count++;
      temp.add(temp1);
    }
    if (!mounted) return;
    setState(() {
      stateList = temp;
    });
  }

  double screenHeight(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.height * percent;

  double screenWidth(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.width * percent;

  @override
  void initState() {
    super.initState();
    getData();
    getDetails();
    totalConfirmed = 0;
    totalRecovered = 0;
    totalDeaths = 0;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true);
    return Scaffold(
        backgroundColor: Color(0xff2C2B4B),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20*2.36),
            ),
            Row(
              children: <Widget>[
                FadeAnimation(1,
                GlobalSituationCard(
                  cardTitle: 'Confirmed',
                  currentData: totalConfirmed,
                  newData: totalNewCases,
                  color: Colors.red,
                  cardColor: Colors.red,
                ),
                ),
                FadeAnimation(
                  1.2,
                  GlobalSituationCard(
                    cardTitle: 'Active',
                    currentData: totalActiveCases,
                    newData: null,
                    color: Colors.blue,
                    cardColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10*2.36),
            ),
            Row(
              children: <Widget>[
                FadeAnimation(
                  1.4,
                  GlobalSituationCard(
                    cardTitle: 'Recovered',
                    currentData: totalRecovered,
                    newData: null,
                    color: Colors.green,
                  ),
                ),
                FadeAnimation(
                  1.6,
                  GlobalSituationCard(
                    cardTitle: 'Death',
                    currentData: totalDeaths,
                    newData: totalNewDeaths,
                    color: Colors.grey,
                    cardColor: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20*2.36),
            ),
            FadeAnimation(
              1.8,
              Center(
                child: Text(
                  "Countries",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: ScreenUtil().setHeight(28*2.36),
                    fontWeight: FontWeight.w600,
                    color: whiteColor
                  )
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5*2.36),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 20,
                      spreadRadius: 3.5,
                      offset: Offset(0, 13)),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Enter Country',
                  hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18*2.36),fontFamily: fontFamily),
                ),
                onChanged: (string) {
                  setState(() {
                    stateList = temp
                        .where((s) => (s.name
                            .toLowerCase()
                            .contains(string.toLowerCase())))
                        .toList();
                  });
                },
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10*2.36)),
            Container(
                padding: const EdgeInsets.all(2.0),
                color: Color(0xff1e1e30),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120*2.36.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1e1e30),
                      ),
                      child: Center(
                        child: Text(
                          'Country',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18*2.36.sp,
                            color: Color(0xff007BFE),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 105*2.36.w,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1e1e30),
                      ),
                      child: Center(
                        child: Text(
                          'Confirmed',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 17.5*2.36.sp,
                            color: Color(0xffFE073A),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110*2.36.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1e1e30),
                      ),
                      child: Center(
                        child: Text(
                          'Recovered',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18*2.36.sp,
                            color: Color(0xff28A645),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 85*2.36.w,
                      margin: EdgeInsets.only(left: 2),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1e1e30),
                      ),
                      child: Center(
                        child: Text(
                          'Deaths',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 18*2.36.sp,
                            color: Color(0xff666f77),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            FadeAnimation(
              2,
              Container(
                padding: EdgeInsets.only(bottom: 10),
                
                height: screenHeight(context) / 1.8,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: stateList.length,
                  itemBuilder: (context, index) {
                    if (stateList[index].name ==
                        'Saint Vincent and the Grenadines') {
                      stateList[index].name = 'Saint Vincent';
                    }
                    return Container(
                        margin: const EdgeInsets.all(2.0),
                        color: Color(0xff1c1c2b),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 122*2.36.w,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1c1c2b),
                              ),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: <Widget>[
                                  Text(
                                    stateList[index].name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 18*2.36.sp,
                                      color: Color(0xff007BFE),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 105*2.36.w,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1c1c2b),
                              ),
                              child: Center(
                                child: Text(
                                  stateList[index].confirmed,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18*2.36.sp,
                                    color: Color(0xffFE073A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 110*2.36.w,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1c1c2b),
                              ),
                              child: Center(
                                child: Text(
                                  stateList[index].recovered,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18*2.36.sp,
                                    color: Color(0xff28A645),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 85*2.36.w,
                              margin: EdgeInsets.only(left: 2),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff1c1c2b),
                              ),
                              child: Center(
                                child: Text(
                                  stateList[index].deaths,
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 18*2.36.sp,
                                    color: Color(0xff666f77),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}

class States {
  int id;
  String name, confirmed, recovered, deaths;
  States(this.id, this.name, this.confirmed, this.recovered, this.deaths);
}
