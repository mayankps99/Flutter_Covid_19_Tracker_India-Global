import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'util/Description.dart';
import 'package:google_fonts/google_fonts.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {

  List<NewsData> newsList = List();
  List<NewsData> temp = List();

  void getNews() async
  {
    var res = await http.get("http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=YOUR_API_KEY");
    var resBody = json.decode(res.body);

    for(var n in resBody["articles"])
    {
      NewsData temp1 = NewsData(n["title"].toString(),n["description"].toString(),n["urlToImage"].toString(),n["url"].toString());
      temp.add(temp1);
    }
    if(!mounted) return;
    setState(() {
      newsList = temp;
    });

  }

  @override
  void initState()
  {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: newsList.length,
            itemBuilder: (context,index)
            {
              return Card(
                elevation: 3,
                child: ListTile(
                  leading: Container(child: Image.network(newsList[index].url,width: 100,height: 100,),),
                  title: Text(newsList[index].title,style: GoogleFonts.cabin(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500  )) ),
                  onTap: ()
                  {
                    var url = newsList[index].urlPage;
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => new DescriptionPage(url,newsList[index].title)
                      )
                    );
                  },
                ),
              );
            }
          ),
      ),
    );
  }
}

class NewsData {
  String title;
  String description;
  String url;
  String urlPage;

  NewsData(this.title, this.description, this.url,this.urlPage);
}