import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;
  bool isWaiting = false;

// to make asynchronous function we'll put async keyword between common bracket and paranthesis
// and add await keyword before the code block
  // void getData() async {
  //   // simulate a netwrok request for a username
  //   // to make code execution to wait for response from Below we can use Asynchronous method
  //   await Future.delayed(
  //       Duration(seconds: 3), () => {print('Varsha')}); //nonblocking code

  //   // below code will execute before the response from the above code block
  //   String userName = await Future.delayed(Duration(seconds: 2), () {
  //     return 'Abhishek chhotta';
  //   }); //nonblocking code

  //   print(userName);
  // }

  // initstate function: it run first when object is created

// here we are overrifding the original function
  // void initState() {
  //   super.initState();
  //   print('Init state function run');
  //   getData();
  // }

  // video 34

  List<WorldTime> location = [
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'france.png'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'russia.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = location[index];
    setState(() {
      isWaiting = true;
    });
    await instance.getTime();
    setState(() {
      isWaiting = false;
    });

    // navigate to home screen:  pop method will remove the previos screen from the stack

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    // build function will run every time when ever setState change the state
    print('Build function run');
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(isWaiting ? 'Loading...' : 'Select Location'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: location.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      print(location[index].location);
                      updateTime(index);
                    },
                    title: Text(location[index].location),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/${location[index].flag}'),
                    ),
                  ),
                ),
              );
            }));
  }
}
