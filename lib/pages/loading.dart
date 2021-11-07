import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  var time = 'Loading';
  // getData() async {
  //   Response response =
  //       await get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));
  //   Map data = jsonDecode(response.body);
  //   print(data);
  //   // get data using key field
  //   print(data['title']);
  // }

  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: 'Mumbai', flag: 'india.png', url: 'Asia/Kolkata');

    await instance.getTime();

    // After data retrieve from api redirect to home route
    // Navigator.pushNamed(context, '/home'); // this method will put the home screen
    // above the loading screen, means loading screen will be active

    // passing data on some routes
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    }); // this will work same as pushName but it will replace the screen

    // setting up the state value;
    // setState(() {
    //   time = instance.time;
    // });
  }

  // initstate function: it run first when object is created
// here we are overrifding the original function
  void initState() {
    super.initState();
    // getData();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 80.0,
          ),
        ));
  }
}
// it's you who is responsible for your sadness non of else.