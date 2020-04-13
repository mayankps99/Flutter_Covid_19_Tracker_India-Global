import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int stateCount = 1;
  List<States> stateList = List<States>();
  void getDetails() async {
    var res = await http.get("https://api.covid19india.org/data.json");
    var resBody = json.decode(res.body);
    List<States> temp = List();

    for (var s in resBody["statewise"]) {
      States temp1 = States(
          s["state"].toString(),
          s["confirmed"].toString(),
          s["active"].toString(),
          s["recovered"].toString(),
          s["deaths"].toString());
      temp.add(temp1);
    }
    setState(() {
      stateList = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: stateList.length,
        itemBuilder: (context, index) {
          if (stateList[index].name == "Total") {
            index++;
          } else {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      stateList[index].name,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      stateList[index].confirmed,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      stateList[index].active,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      stateList[index].recovered,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      stateList[index].deaths,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class States {
  String name, confirmed, active, recovered, deaths;
  States(this.name, this.confirmed, this.active, this.recovered, this.deaths);
}
