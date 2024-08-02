import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String video_url;

  VideoPlayerWidget({required this.video_url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;
  bool _isConnected = false;
  double _volume = 100;
  double _previousVolume = 100;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
      if (_isConnected) {
        _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(widget.video_url)!,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected
        ? YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                playedColor: Colors.green,
                handleColor: Colors.greenAccent,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                  SizedBox(height: 10),
                  _buildVolumeControl(),
                ],
              );
            },
          )
        : Center(
            child: Text(
              'No internet connection. Please connect to the internet to play the video.',
              style: TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget _buildVolumeControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(_volume == 0 ? Icons.volume_off : Icons.volume_up),
          onPressed: () {
            setState(() {
              if (_volume == 0) {
                _volume = _previousVolume;
                _controller.setVolume(_volume.round());
              } else {
                _previousVolume = _volume;
                _volume = 0;
                _controller.setVolume(_volume.round());
              }
            });
          },
        ),
        Expanded(
          child: Slider(
            value: _volume,
            min: 0,
            max: 100,
            divisions: 100,
            label: _volume.round().toString(),
            activeColor: Colors.green,
            inactiveColor: Colors.green.withOpacity(0.5),
            onChanged: (value) {
              setState(() {
                _volume = value;
                _controller.setVolume(_volume.round());
              });
            },
          ),
        ),
      ],
    );
  }
}
