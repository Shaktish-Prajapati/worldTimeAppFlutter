import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  var location; // location name for UI
  var time; // time in that location
  var flag; // url to assest flag icon
  var url; // location URL for api endpoint
  bool isDayTime = false; // it show day or not

  WorldTime({this.location, this.flag, this.url});

// TO use await keyword we need to return promise from the function, Future is kind of promise in JS
  // future promises at some point in future I am gon a return void but when function execution is complete
  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
      // Json decode response
      Map data = jsonDecode(response.body);
      print(data);

      // get properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);

      // create date time object
      DateTime now = DateTime.parse(
          datetime); // it will convert the datetime into DateTime object
      // now.add(Duration(
      // hours: int.parse("${offset.split(':')[0]}.${offset.split(':')[1]}")))
      now = now.add(Duration(hours: int.parse("${offset}")));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      // set the time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error $e');
      time = 'Could not get time data';
    }
  }
}
