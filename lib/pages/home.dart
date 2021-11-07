// import 'dart:html';

// import 'dart:html';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // we receive the argument in build method

    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(data);

    // set background image
    String bgImage = data['isDayTime'] ? 'day.jpeg' : 'night.jpg';
    bool bgColor = data['isDayTime'] ? true : false;

    return Scaffold(
      backgroundColor: bgColor ? Colors.blue : Colors.indigo[700],
      // SafeArea widget brings down the home screen text down in the safe area
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      print(result);
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.red[300],
                    ),
                    label: Text(
                      'Edit location',
                      style: TextStyle(
                          fontSize: 20,
                          color: data['isDayTime']
                              ? Colors.white
                              : Colors.white70),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/${data["flag"]}')),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 38,
                          letterSpacing: 2,
                          color: data['isDayTime']
                              ? Colors.white
                              : Colors.white70),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                      fontSize: 66,
                      color: data['isDayTime'] ? Colors.white : Colors.white70),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
