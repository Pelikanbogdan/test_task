import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UnauthorizedScreen extends StatefulWidget {
  @override
  _UnauthorizedScreenState createState() => _UnauthorizedScreenState();
}

class _UnauthorizedScreenState extends State<UnauthorizedScreen> {
  late VideoPlayerController _firstVideoController;
  late VideoPlayerController _secondVideoController;
  bool isFirstVideoMuted = true;
  bool isSecondVideoMuted = true;

  @override
  void initState() {
    super.initState();
    _firstVideoController = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => _firstVideoController.play());
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
    _firstVideoController.dispose();
    _secondVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.10,
              color: Colors.blue[50],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Front Camera',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (isFirstVideoMuted) {
                                      _firstVideoController.setVolume(1);
                                      isFirstVideoMuted = false;
                                      _secondVideoController.setVolume(0);
                                      isSecondVideoMuted = true;
                                    } else {
                                      _firstVideoController.setVolume(0);
                                      isFirstVideoMuted = true;
                                    }
                                  },
                                  icon: isFirstVideoMuted
                                      ? Icon(Icons.mic_off_sharp,
                                          color: Colors.blue[100], size: 35.0)
                                      : Icon(
                                          Icons.mic_sharp,
                                          color: Colors.blue[100],
                                          size: 35.0,
                                        ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.zoom_out_map,
                                    color: Colors.blue[100],
                                    size: 35.0,
                                  ),
                                ),
                              ],
                            ),
                            height: 64,
                            width: size.width * 0.48,
                            color: Colors.blue[900],
                          ),
                          Container(
                            child: AspectRatio(
                                aspectRatio:
                                    _firstVideoController.value.aspectRatio,
                                child: VideoPlayer(_firstVideoController)),
                            color: Colors.blue[100],
                            height: size.height * 0.5,
                            width: size.width * 0.48,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Back Camera',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (isSecondVideoMuted) {
                                      _secondVideoController.setVolume(1);
                                      isSecondVideoMuted = false;
                                      _firstVideoController.setVolume(0);
                                      isFirstVideoMuted = true;
                                    } else {
                                      _secondVideoController.setVolume(0);
                                      isSecondVideoMuted = true;
                                    }
                                  },
                                  icon: isSecondVideoMuted
                                      ? Icon(Icons.mic_off_sharp,
                                          color: Colors.blue[100], size: 35.0)
                                      : Icon(
                                          Icons.mic_sharp,
                                          color: Colors.blue[100],
                                          size: 35.0,
                                        ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.zoom_out_map,
                                    color: Colors.blue[100],
                                    size: 35.0,
                                  ),
                                ),
                              ],
                            ),
                            height: 64,
                            width: size.width * 0.48,
                            color: Colors.blue[900],
                          ),
                          Container(
                            child: AspectRatio(
                                aspectRatio:
                                    _secondVideoController.value.aspectRatio,
                                child: VideoPlayer(_secondVideoController)),
                            color: Colors.blue[100],
                            height: size.height * 0.5,
                            width: size.width * 0.48,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
