import 'package:covid19_tracker_demo/util/card.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'util/resource.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<States> stateList = List<States>();
  List<States> temp = List();
  int stateCount = 1;
  void getDetails() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var resBody = json.decode(res.body);

    for (var s in resBody["statewise"]) {
      States temp1 = States(
          stateCount,
          s["state"].toString(),
          s["confirmed"].toString(),
          s["recovered"].toString(),
          s["deaths"].toString());
      stateCount++;
      temp.add(temp1);
    }
    if (!mounted) return;
    setState(() {
      stateList = temp;
      stateList.removeAt(0);
    });
  }

  double borderRadius = 0.0;

  int totalConfirmedIndia;
  int totalActiveIndia;
  int totalRecoveredIndia;
  int totalDeathsIndia;
  int dailyNewConfirmedIndia;
  int dailyNewRecoveredIndia;
  int dailyNewDeathsIndia;
  int dailyNewActiveIndia;

  getDataIndia() async {
    print("StartIndia");
    var response = await http.get("https://api.covid19india.org/data.json",
        headers: {"Accept": "application/json"});
    var responseBody = response.body;
    Map<String, dynamic> obj = jsonDecode(responseBody);
    if (!mounted) return;
    setState(() {
      totalConfirmedIndia = int.parse(obj["statewise"][0]["confirmed"]);
      totalActiveIndia = int.parse(obj["statewise"][0]["active"]);
      totalRecoveredIndia = int.parse(obj["statewise"][0]["recovered"]);
      totalDeathsIndia = int.parse(obj["statewise"][0]["deaths"]);
      dailyNewConfirmedIndia = int.parse(obj["statewise"][0]["deltaconfirmed"]);
      dailyNewRecoveredIndia = int.parse(obj["statewise"][0]["deltarecovered"]);
      dailyNewDeathsIndia = int.parse(obj["statewise"][0]["deltadeaths"]);
      dailyNewActiveIndia =
          dailyNewConfirmedIndia - dailyNewDeathsIndia - dailyNewRecoveredIndia;
    });
    print("\nEnd");
  }

  List<GlobalKey> heightKey = List<GlobalKey>();
  double screenHeight(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.height * percent;

  double screenWidth(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.width * percent;

  @override
  void initState() {
    super.initState();
    getDataIndia();
    getDetails();
    stateCount = 0;
    dailyNewActiveIndia = 0;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
        backgroundColor: Color(0xff2C2B4B),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(20 * 2.36),
              ),
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FadeAnimation(
                            1,
                            GlobalSituationCard(
                              cardTitle: 'Confirmed',
                              currentData: totalConfirmedIndia,
                              newData: dailyNewConfirmedIndia,
                              color: Colors.red,
                              cardColor: Colors.red,
                            ),
                          ),
                          FadeAnimation(
                            1.2,
                            GlobalSituationCard(
                              cardTitle: 'Active',
                              currentData: totalActiveIndia,
                              newData: dailyNewActiveIndia,
                              color: Colors.blue,
                              cardColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10 * 2.36),
                      ),
                      Row(
                        children: <Widget>[
                          FadeAnimation(
                            1.4,
                            GlobalSituationCard(
                              cardTitle: 'Recovered',
                              currentData: totalRecoveredIndia,
                              newData: dailyNewRecoveredIndia,
                              color: Colors.green,
                            ),
                          ),
                          FadeAnimation(
                            1.6,
                            GlobalSituationCard(
                              cardTitle: 'Death',
                              currentData: totalDeathsIndia,
                              newData: dailyNewDeathsIndia,
                              color: Colors.grey,
                              cardColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20 * 2.36)),
              FadeAnimation(
                1.8,
                Center(
                  child: Text(
                    "States/UT",
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: ScreenUtil().setSp(28 * 2.36),
                        fontWeight: FontWeight.w600,
                        color: whiteColor),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5 * 2.36),
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
                    hintText: 'Enter State or UT',
                    hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(18 * 2.36),
                        fontFamily: fontFamily),
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
              SizedBox(height: ScreenUtil().setHeight(10 * 2.36)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      size: 25*2.36.sp,
                      color: fontLight,
                    ),
                    Spacer(),
                    Container(
                      width: 390*2.36.w,
                      child: Text(
                        'MoHFW website reports that cases in the States Unassigned are the cases that are being reassigned to states',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: fontLight,
                          fontSize: 16*2.36.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10 * 2.36)),
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
                          'State/UT',
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
                      // index++;
                      
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        color: Color(0xff1c1c2b),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 123*2.36.w,
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
            ],
          ),
        ));
  }
}

class States {
  int id;
  String name, confirmed, recovered, deaths;
  States(this.id, this.name, this.confirmed, this.recovered, this.deaths);
}
