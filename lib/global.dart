import 'package:covid19_tracker_demo/util/card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Animation/FadeAnimation.dart';

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
  int count=1;
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
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            GlobalSituationCard(
              cardTitle: 'Confirmed CASES',
              caseTitle: 'Confirmed',
              currentData: totalConfirmed,
              newData: totalNewCases,
              color: Colors.red,
              cardColor: Colors.red,
            ),
            SizedBox(height: 10),
            FadeAnimation(1, GlobalSituationCard(
              cardTitle: 'Active CASES',
              caseTitle: 'Active',
              currentData: totalActiveCases,
              newData: null,
              color: Colors.blue,
              cardColor: Colors.blue,
            ),),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(1.2,GlobalSituationCard(
              cardTitle: 'Recovered CASES',
              caseTitle: 'Recovered',
              currentData: totalRecovered,
              newData: null,
              color: Colors.green,
            ),),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(1.4,GlobalSituationCard(
              cardTitle: 'Death CASES',
              caseTitle: 'Deaths',
              currentData: totalDeaths,
              newData: totalNewDeaths,
              color: Colors.grey,
              cardColor: Colors.grey,
            ),),
            SizedBox(
              height: 20,
            ),
            FadeAnimation(1.8,Center(
              child: Text(
                "Countries",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),),
            SizedBox(height: 5,),
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
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  onChanged:(string){
                    setState(() {
                      stateList = temp.where((s)=>(s.name.toLowerCase().contains(string.toLowerCase()))).toList();
                    });
                  } ,
                ),
              ),
            SizedBox(height: 10),
            FadeAnimation(2,Container(
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.all(5),
              height: screenHeight(context) / 1.8,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: stateList.length,
                itemBuilder: (context, index) {
                  if (stateList[index].name ==
                      'Saint Vincent and the Grenadines') {
                    stateList[index].name = 'Saint Vincent';
                  }
                  return Card(
                    color: Color(0xFFFF8367),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(5)),
                                child: RichText(
                                  text: TextSpan(
                                      text: stateList[index].name,
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 17),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(5)),
                                child: RichText(
                                  text: TextSpan(
                                      text: stateList[index].id.toString(),
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      stateList[index].confirmed,
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                    Text(
                                      "Confirmed",
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      stateList[index].recovered,
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                    Text(
                                      "Recovered",
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      stateList[index].deaths,
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                    Text(
                                      "Deaths",
                                      style: GoogleFonts.cabin(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // }
                },
              ),
            ),),
          ]),
        ));
  }
}

class States {
  int id;
  String name, confirmed, recovered, deaths;
  States(this.id,this.name, this.confirmed, this.recovered, this.deaths);
}
