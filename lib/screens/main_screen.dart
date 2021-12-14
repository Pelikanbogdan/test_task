import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_task/model/car.dart';
import 'package:test_task/screens/welcome_screen.dart';
import 'package:test_task/services/api_service.dart';
import 'package:test_task/services/preferences_service.dart';
import 'package:test_task/widgets/car_element.dart';
import 'package:video_player/video_player.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String dropDownValue = 'No Filter';
  var items = [
    'No Filter',
    'available',
    'hidden',
    'disabled',
  ];
  late VideoPlayerController _controller;
  late VideoPlayerController _secondVideoController;
  int secondsPassed = 0;
  late Timer refreshTimer;
  late Timer secondsTimer;
  List<Car> _originalCars = [];
  List<Car> _cars = [];
  final dataApi = ApiService();
  String loginName = '';
  final _preferencesService = PreferencesService();

  void setUserName() async {
    final settings = await _preferencesService.getLoginName();
    setState(() => loginName = settings);
  }

  @override
  void initState() {
    super.initState();
    setUserName();
    dataApi.fetchCars().then((value) {
      _originalCars.clear();
      _originalCars.addAll(value);
      _cars.clear();
      _cars.addAll(_originalCars);
    });
    secondsTimer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              secondsPassed++;
            }));
    refreshTimer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => setState(() {
              dataApi.fetchCars().then((value) {
                secondsPassed = 0;
                _originalCars.clear();
                _originalCars.addAll(value);
                _cars.clear();
                _cars.addAll(_originalCars.where((element) {
                  if (dropDownValue != 'No Filter') {
                    return element.state == dropDownValue;
                  } else {
                    return true;
                  }
                }));
              });
            }));
    _controller = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => _controller.play());
    _secondVideoController = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => _secondVideoController.play());
  }

  @override
  void dispose() {
    refreshTimer.cancel();
    secondsTimer.cancel();
    _controller.dispose();
    _secondVideoController.dispose();
    _preferencesService.saveLoginName('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            Column(children: [
              Container(
                height: 60,
                width: size.width * 0.25,
                color: Colors.blue[50],
                child: Center(
                  child: DropdownButton(
                    value: dropDownValue,
                    items: items.map((items) {
                      return DropdownMenuItem(
                        child: Text(
                          items,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue ?? 'No Filter';
                        _cars.clear();
                        _cars.addAll(_originalCars.where((element) {
                          if (dropDownValue != 'No Filter') {
                            return element.state == dropDownValue;
                          } else {
                            return true;
                          }
                        }));
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: size.height * 0.8,
                width: size.width * 0.25,
                color: Colors.white,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  padding: EdgeInsets.all(25),
                  itemCount: _cars.length,
                  itemBuilder: (context, index) {
                    return CarElement(car: _cars[index]);
                  },
                ),
              )
            ]),
            VerticalDivider(
              color: Colors.blue[100],
              thickness: 1.5,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: size.width * 0.73,
                    height: 60,
                    color: Colors.blue[50],
                    child: Container(
                      color: Colors.blue[900],
                      height: 60,
                      width: size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Hello, ' + loginName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: TextButton(
                              onPressed: () {
                                _preferencesService.saveLoginName('');
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) {
                                    return WelcomeScreen();
                                  }),
                                );
                              },
                              child: Text(
                                'log out',
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: size.width * 0.33,
                                color: Colors.blue[900],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Front Camera',
                                        style: TextStyle(
                                            color: Colors.blue[50],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.mic_sharp,
                                        color: Colors.blue[200],
                                        size: 35.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.zoom_out_map,
                                        color: Colors.blue[200],
                                        size: 35.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller)),
                                color: Colors.blue[100],
                                height: size.height * 0.33,
                                width: size.width * 0.33,
                              ),
                              Spacer(),
                              Text(
                                'Data from API updated $secondsPassed seconds ago...',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: size.width * 0.33,
                                color: Colors.blue[900],
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'Back Camera',
                                        style: TextStyle(
                                            color: Colors.blue[50],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.mic_off,
                                        color: Colors.blue[200],
                                        size: 35.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.zoom_out_map,
                                        color: Colors.blue[200],
                                        size: 35.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: AspectRatio(
                                    aspectRatio: _secondVideoController
                                        .value.aspectRatio,
                                    child: VideoPlayer(_secondVideoController)),
                                color: Colors.blue[100],
                                height: size.height * 0.33,
                                width: size.width * 0.33,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
