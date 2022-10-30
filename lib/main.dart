import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  // Logic Side of the Abb
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String digitSecond = '00', digitMinutes = '00', digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  //Making Buttons Functional

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

// Reset Button
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSecond = '00';
      digitMinutes = '00';
      digitHours = '00';

      started = false;
    });
  }
  // adding laps

  void addLaps() {
    String lap = '$digitHours:$digitMinutes:$digitSecond';
    setState(() {
      laps.add(lap);
    });
  }

  //Creating Starter timer
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSecond = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSecond > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSecond = 0;
        }
      }
      setState(() {
        seconds = localSecond;
        minutes = localMinutes;
        hours = localHours;

        digitSecond = (seconds >= 10) ? '$seconds' : '0$seconds';
        digitMinutes = (minutes >= 10) ? '$minutes' : '0$minutes';
        digitHours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'StopWatch App',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSecond',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 88, 117),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lap no${index + 1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Lap no${laps[index]}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ));
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started) ? 'start' : 'Pause',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(Icons.flag),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
