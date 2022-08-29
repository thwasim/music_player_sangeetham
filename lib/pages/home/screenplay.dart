import 'package:Music_player/pages/favourtie/favouritebutton.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class Screenplay extends StatefulWidget {
  Screenplay({Key? key, required this.songlist}) : super(key: key);

  static List<SongModel>? playingdetails = [];
  List<SongModel>? songlist = [];
  @override
  State<Screenplay> createState() => _ScreenplayState();
}

class _ScreenplayState extends State<Screenplay> {
  String currentSongTitle = '';
  int currentIndex = 0;
  bool shufflecheck = false;

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          MyHomePage.player.positionStream,
          MyHomePage.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));

  @override
  void initState() {
    Screenplay.playingdetails!.clear();
    for (var i = 0; i < widget.songlist!.length; i++) {
      Screenplay.playingdetails!.add(widget.songlist![i]);
    }
    super.initState();

    // update the current playing song index listener
    MyHomePage.player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayingSongDetails(index);
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.only(top: 56.0, right: 20.0, left: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                           widget.songlist![currentIndex].title,
                            maxLines: 2,
                            style: TextStyle(
                              color: Color.fromARGB(179, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        flex: 7,
                      ),
                    ],
                  ),
                  //artwork container
                  GestureDetector(
                    onHorizontalDragEnd: (DragDownDetails) {
                      if (DragDownDetails.primaryVelocity! < 0) {
                        if (MyHomePage.player.hasNext) {
                          MyHomePage.player.seekToNext();
                          setState(() {});
                        }
                      } else if (DragDownDetails.primaryVelocity! > 0) {
                        if (MyHomePage.player.hasPrevious) {
                          MyHomePage.player.seekToPrevious();
                          setState((){});
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      height: MediaQuery.of(context).size.height * 0.35,
                      margin: const EdgeInsets.only(top: 40, bottom: 30),
                      child: QueryArtworkWidget(
                        id: widget.songlist![currentIndex].id,
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.circular(0.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: StreamBuilder<DurationState>(
                          stream: _durationStateStream,
                          builder: (context, snapshot) {
                            final durationState = snapshot.data;
                            final progress =
                                durationState?.position ?? Duration.zero;
                            final total = durationState?.total ?? Duration.zero;
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: ProgressBar(
                                progress: progress,
                                total: total,
                                barHeight: 3.0,
                                baseBarColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                progressBarColor:
                                    Color.fromARGB(255, 79, 77, 77),
                                thumbColor: Color.fromARGB(153, 218, 223, 211),
                                timeLabelTextStyle: TextStyle(
                                  fontSize: 15,
                                ),
                                onSeek: (duration) {
                                  MyHomePage.player.seek(duration);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //skip to previous
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              if (MyHomePage.player.hasPrevious) {
                                MyHomePage.player.seekToPrevious();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        //play pause
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              if (MyHomePage.player.playing) {
                                MyHomePage.player.pause();
                              } else {
                                if (MyHomePage.player.currentIndex != null) {
                                  MyHomePage.player.play();
                                }
                              }
                            },
                            child: Container(
                              decoration: getDecoration(
                                  BoxShape.circle, Offset(0.5, 0.3), 1, 0),
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only( left: 15),
                              child: StreamBuilder<bool>(
                                stream: MyHomePage.player.playingStream,
                                builder: (context, snapshot) {
                                  bool? playingState = snapshot.data;
                                  if (playingState != null && playingState) {
                                    return const Icon(
                                      Icons.pause,
                                      size: 50,
                                      color: Colors.black,
                                    );
                                  }
                                  return const Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                            SizedBox(width: 11,),
                        //skip to next
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              if (MyHomePage.player.hasNext) {
                                MyHomePage.player.seekToNext();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.skip_next,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //go to  shuffle , repeat all and repeat one control buttons
                  Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //shuffle playlist
                          Flexible(
                            child: InkWell(onTap: () {
                              if (shufflecheck == false) {
                                MyHomePage.player.setShuffleModeEnabled(true);
                                shufflecheck = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 190),
                                      content: Text('Shuffle Mode On'),
                                      margin: EdgeInsets.all(20),
                                      behavior: SnackBarBehavior.floating),
                                );
                                setState(() {});
                              } else {
                                MyHomePage.player.setShuffleModeEnabled(false);
                                shufflecheck = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 190),
                                      content: Text('Shuffle Mode Off'),
                                      margin: EdgeInsets.all(20),
                                      behavior: SnackBarBehavior.floating),
                                );
                                setState(() {});
                              }
                            }, child: Builder(builder: ((context) {
                              if (shufflecheck == false) {
                                return Container(
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.only(
                                      right: 40.0, left: 10.0),
                                  child: const Icon(
                                    Icons.shuffle,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return Container(
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.only(
                                      right: 40.0, left: 10.0),
                                  child: const Icon(
                                    Icons.shuffle_on_outlined,
                                    size: 20,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                  ),
                                );
                              }
                            }))),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Flexible(
                              child: InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0),
                              child: FavFunction(

                                index: currentIndex,
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 50,
                          ),
                          // repeat mode
                          Flexible(
                              child: InkWell(
                            onTap: () {
                              MyHomePage.player.loopMode == LoopMode.one
                                  ? MyHomePage.player.setLoopMode(LoopMode.all)
                                  : MyHomePage.player.setLoopMode(LoopMode.one);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: StreamBuilder<LoopMode>(
                                  stream: MyHomePage.player.loopModeStream,
                                  builder: (context, snapshot) {
                                    final loopMode = snapshot.data;
                                    if (LoopMode.one == loopMode) {
                                      return Icon(
                                        Icons.repeat_one,
                                        size: 25,
                                        color: Colors.red,
                                      );
                                    }
                                    return Icon(
                                      Icons.repeat,
                                      size: 25,
                                      color: Colors.white,
                                    );
                                  },
                                )),
                          )),
                        ],
                      )),
                ],
              ))),
    );
  }

  void _updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (MyHomePage.songs.isNotEmpty) {
        currentSongTitle =  widget.songlist![currentIndex].title;
        currentIndex = index;
      }
    });
  }
}

BoxDecoration getDecoration(
    BoxShape boxShape, Offset offset, double blurRadius, double spreadRadius) {
  return BoxDecoration(color: Colors.white, shape: BoxShape.circle);
}