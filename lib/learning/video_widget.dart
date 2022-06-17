import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidget({Key? key, required this.url, required this.play})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
    );
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(false);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(false);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(15.0),
                          child: VideoPlayer(_controller)),
                    ),
                  ),
                ),
                //FURTHER IMPLEMENTATION
              ],
            );
          } else {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.slow_motion_video,
                    size: 60,
                    color: Colors.blue.shade400,
                  ),
                ),
                SpinKitThreeBounce(
                  color: Colors.blue.shade400,
                  size: 20,
                ),
              ],
            ));
          }
        },
      ),
    );
  }
}
