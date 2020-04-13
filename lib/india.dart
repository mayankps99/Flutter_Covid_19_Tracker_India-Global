import 'package:covid19_tracker_demo/util/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  List<States> stateList = List<States>();
  List<States> temp = List();
  int stateCount=1;
  void getDetails() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var resBody = json.decode(res.body);
    

    for (var s in resBody["statewise"]) {
      States temp1 = States(stateCount,s["state"].toString(), s["confirmed"].toString(),
          s["recovered"].toString(), s["deaths"].toString());
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
      dailyNewConfirmedIndia =
          int.parse(obj["statewise"][0]["deltaconfirmed"]);
      dailyNewRecoveredIndia =
          int.parse(obj["statewise"][0]["deltarecovered"]);
      dailyNewDeathsIndia = int.parse(obj["statewise"][0]["deltadeaths"]);
      dailyNewActiveIndia= dailyNewConfirmedIndia - dailyNewDeathsIndia - dailyNewRecoveredIndia;
    });
    print("\nEnd");
  }
  

  double screenHeight(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.height * percent;

  double screenWidth(BuildContext context, {double percent = 1}) =>
      MediaQuery.of(context).size.width * percent;

  @override
  void initState() {
    super.initState();
    getDataIndia();
    getDetails();
    stateCount=0;
    dailyNewActiveIndia=0;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              FadeAnimation(1,GlobalSituationCard(
                cardTitle: 'Confirmed CASES',
                caseTitle: 'Confirmed',
                currentData: totalConfirmedIndia,
                newData: dailyNewConfirmedIndia,
                color: Colors.red,
                cardColor: Colors.red,
              ),),
              SizedBox(height: 10),
              FadeAnimation(1.2,GlobalSituationCard(
                cardTitle: 'Active CASES',
                caseTitle: 'Active',
                currentData: totalActiveIndia,
                newData: dailyNewActiveIndia,
                color: Colors.blue,
                cardColor: Colors.blue,
              ),),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.4, GlobalSituationCard(
                cardTitle: 'Recovered CASES',
                caseTitle: 'Recovered',
                currentData: totalRecoveredIndia,
                newData: dailyNewRecoveredIndia,
                color: Colors.green,
              ),),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.6, GlobalSituationCard(
                cardTitle: 'Death CASES',
                caseTitle: 'Deaths',
                currentData: totalDeathsIndia,
                newData: dailyNewDeathsIndia,
                color: Colors.grey,
                cardColor: Colors.grey,
              ),),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "States/UT",
                  style: GoogleFonts.cabin(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 5,
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
              FadeAnimation(1.8, Container(
                padding: EdgeInsets.only(bottom:10),
                margin: EdgeInsets.all(5),
              height: screenHeight(context)/1.8,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: stateList.length,
                itemBuilder: (context, index) {
                  // index++;
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
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: RichText(
                                  text: TextSpan(text: stateList[index].name,style: GoogleFonts.cabin(
                                    textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20)
                                  )),
                                    ),
                              ),
                              Spacer(),
                              Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: RichText(
                              text: TextSpan(text: stateList[index].id.toString(),style: GoogleFonts.cabin(
                                textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20)
                              )),
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
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
                                    ),
                                    Text(
                                      "Confirmed",
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      stateList[index].recovered,
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
                                    ),
                                    Text(
                                      "Recovered",
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      stateList[index].deaths,
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
                                    ),
                                    Text(
                                      "Deaths",
                                      style:GoogleFonts.cabin(textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w700,fontSize: 20 )),
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
            ],
          ),
        ));
  }
}

class States {
  int id;
  String name, confirmed, recovered, deaths;
  States(this.id,this.name, this.confirmed, this.recovered, this.deaths);
}
