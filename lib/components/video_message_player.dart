import 'package:flutter/material.dart';
import 'package:localservice/components/fullscreen_video_player.dart';

class VideoMessagePlayer extends StatefulWidget {
  final String uri;
  final num size;
  final String name;
  final Function onDownload;
  const VideoMessagePlayer(
      {required this.uri,
      required this.size,
      required this.name,
      required this.onDownload,
      Key? key})
      : super(key: key);

  @override
  State<VideoMessagePlayer> createState() => _VideoMessagePlayerState();
}

class _VideoMessagePlayerState extends State<VideoMessagePlayer> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.play_circle_fill,
          ),
          iconSize: 50,
          onPressed: () {
            showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext, Animation animation,
                    Animation secondaryAnimation) {
                  return Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.all(20),
                        child: FullScreenVideoPlayer(
                            title: widget.name, uri: widget.uri)),
                  );
                });
          },
        ),
        SizedBox(
            width: 120,
            child: Text(
              widget.name,
              maxLines: 3,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            )),

        IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {
            widget.onDownload();
          },
        ),
        // Opens volume slider dialog
      ],
    );
  }
}
