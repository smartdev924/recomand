import 'package:flutter/material.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:localservice/components/common.dart';

class ControlButtons extends StatefulWidget {
  final String uri;
  final Function onDownload;

  const ControlButtons({required this.uri, required this.onDownload, Key? key})
      : super(key: key);

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.uri)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 30),
            // Opens volume slider dialog
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {
                showSliderDialog(
                  context: context,
                  title: "Adjust volume",
                  divisions: 10,
                  min: 0.0,
                  max: 1.0,
                  value: _player.volume,
                  stream: _player.volumeStream,
                  onChanged: _player.setVolume,
                );
              },
            ),

            /// This StreamBuilder rebuilds whenever the player state changes, which
            /// includes the playing/paused state and also the
            /// loading/buffering/ready state. Depending on the state we show the
            /// appropriate button or loading indicator.
            StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 48,
                    height: 48,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 48,
                    onPressed: _player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 48,
                    onPressed: _player.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.replay),
                    iconSize: 48,
                    onPressed: () => _player.seek(Duration.zero),
                  );
                }
              },
            ),
            // Opens speed slider dialog
            StreamBuilder<double>(
              stream: _player.speedStream,
              builder: (context, snapshot) => IconButton(
                icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  showSliderDialog(
                    context: context,
                    title: "Adjust speed",
                    divisions: 10,
                    min: 0.5,
                    max: 1.5,
                    value: _player.speed,
                    stream: _player.speedStream,
                    onChanged: _player.setSpeed,
                  );
                },
              ),
            ),
          ],
        )),
        IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {
            widget.onDownload();
          },
        ),
      ],
    );
  }
}
