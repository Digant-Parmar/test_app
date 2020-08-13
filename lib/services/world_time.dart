import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;


  WorldTime({this.location,this.flag,this.url});


  Future<void> getTime() async{


    try{

      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1,3);
      String offsetMin = data['utc_offset'].toString().substring(4,6);

      //print(dateTime);
//      print(offset);
//      print(offsetMin);


      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offsetMin)));
      print(now);

      isDaytime = now.hour > 6 && now.hour <20 ? true :false;
      print(isDaytime);

      time = DateFormat.jm().format(now);


    }catch(e){

      print(e);
      time = 'could not get the time';
    }

  }
}