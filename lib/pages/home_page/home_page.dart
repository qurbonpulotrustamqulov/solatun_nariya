import 'dart:core';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solaatun_nariya/main.dart';
import 'package:solaatun_nariya/pages/document_page/document_page.dart';
import 'package:solaatun_nariya/pages/history_page/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferPosition, duration) => PositionData(
              position, bufferPosition, duration ?? Duration.zero));

  Future<void> _incrementCounter() async {
    setState(() {
      repository.storeCounter();
    });
  }

  Future<void> _incrementZero() async {
    setState(() {
      repository.storeZero();
    });
  }

  @override
  void initState() {
    _audioPlayer = AudioPlayer()..setAsset("assets/audio/solaatan_nariya.m4a");
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int counter = repository.readCounter();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            "assets/images/img_basmala.jpg",
            height: 70,
          ),
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  _incrementZero();
                },
                icon: Icon(
                  CupertinoIcons.refresh,
                  color: Colors.black,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  child: PageView(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image.asset(
                            "assets/images/img_solaatun_nariya_arabic.jpg",
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Text("Lotin alifbosida>>"),
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.asset(
                            "assets/images/img_solaatun_nariya_latin.jpg",
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text("<< Arab alifbosida"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [  Controls(audioPlayer: _audioPlayer),
                    SizedBox(width: 5,),
                    StreamBuilder<PositionData>(stream: _positionDataStream, builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ProgressBar(progress: positionData?.position??Duration.zero, buffered: positionData?.bufferPosition??Duration.zero,total: positionData?.duration??Duration.zero,
                            onSeek: _audioPlayer.seek,
                            barHeight: 5,
                            thumbRadius: 5,
                            thumbGlowRadius: 0.1,
                            timeLabelTextStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400,color: Colors.black),
                            baseBarColor: Colors.grey,
                            progressBarColor: Colors.black,
                            thumbColor: Colors.black,),
                        ),
                      );
                    },),],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 170,
                      width: 180,
                      child: Center(
                          child: Text(
                        counter.toString(),
                        style: const TextStyle(fontSize: 35),
                      )),
                    ),
                    const SizedBox(
                      height: 170,
                      child: VerticalDivider(
                        width: 8,
                      ),
                    ),
                    InkWell(
                      child: const SizedBox(
                        height: 170,
                        width: 180,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.history,
                                size: 45,
                              ),
                              Text(
                                "Tarix",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HistoryPage(),
                            ));
                      },
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: const SizedBox(
                        height: 170,
                        width: 180,
                        child: Icon(
                          CupertinoIcons.doc_plaintext,
                          size: 40,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DocumentPage(),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 170,
                      child: VerticalDivider(
                        width: 8,
                      ),
                    ),
                    InkWell(
                      child: const SizedBox(
                        height: 170,
                        width: 180,
                        child: Icon(
                          Icons.touch_app_outlined,
                          size: 45,
                        ),
                      ),
                      onTap: () {
                        _incrementCounter();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return GestureDetector(
            onTap: audioPlayer.play,
              child: Icon(Icons.play_arrow_rounded));
        } else if (processingState != ProcessingState.completed) {
          return GestureDetector(
            onTap: audioPlayer.pause,
            child: Icon(
              Icons.pause_rounded,
              color: Colors.black,
            ),
          );
        }
        return GestureDetector(
          onTap:() {
            audioPlayer.setAsset("assets/audio/solaatan_nariya.m4a");
            audioPlayer.play;
          },
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.black,
          ),
        );
      },
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferPosition;
  final Duration duration;

  const PositionData(this.position, this.bufferPosition, this.duration);
}
