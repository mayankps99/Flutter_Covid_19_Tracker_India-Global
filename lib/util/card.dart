import 'color.dart';
import 'margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';
import 'resource.dart';

class GlobalSituationCard extends StatelessWidget {
  final String cardTitle;
  final int currentData;
  final int newData;
  final Color color;
  final Color cardColor;

  const GlobalSituationCard(
      {Key key,
      @required this.cardTitle,
      @required this.currentData,
      @required this.newData,
      this.cardColor = CardColors.green,
      @required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    ScreenUtil.init(context,allowFontScaling: true);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth( 218*2.36),
            height: screenHeight(context, percent: 0.21),
            margin: EdgeInsets.symmetric(horizontal:5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 20,
                    spreadRadius: 3.5,
                    offset: Offset(0, 13)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(40*2.36),
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CardColors.transparentBlack,
                          borderRadius: BorderRadius.circular(5)),
                      child: RichText(
                        text: 
                              TextSpan(
                                text: "$cardTitle"
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: ScreenUtil().setSp(16*2.36),
                                  fontWeight: FontWeight.w600,
                                  color: cardColor,
                                ),
                              )
                           
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currentData != null
                                ? formatter.format(currentData)
                                : '-',
                            style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: ScreenUtil().setSp(22*2.36),
                                  fontWeight: FontWeight.w600,
                                  color: cardColor,
                                )
                          ),
                          
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            newData != null
                                ? formatter.format(newData)
                                : '',
                            style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: ScreenUtil().setSp(22*2.36),
                                  fontWeight: FontWeight.w600,
                                  color: cardColor,
                                )
                          ),
                          const YMargin(5),
                          Text(
                            newData != null?
                            "New":'',
                            style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: ScreenUtil().setSp(16*2.36),
                                  fontWeight: FontWeight.w600,
                                  color: cardColor.withOpacity(0.5),
                                )
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}