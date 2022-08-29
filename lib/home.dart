import 'package:Music_player/pages/favourtie/favourite.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:Music_player/pages/home/screenplay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'pages/playlist/playlist.dart';
import 'pages/searchpage.dart';

// ignore: must_be_immutable
class MyHomePages extends StatefulWidget {
  MyHomePages({Key? key}) : super(key: key);
  List<SongModel>? fianllist = [];

  @override
  State<MyHomePages> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> {
  int _currentIndex = 0;
  List<Widget> page = [
    MyHomePage(),
    SearchScreen(),
    PlayList(),
    FavouritePage(),
  ];

  @override
  void initState() {
    MyHomePage.player.currentIndexStream.listen((event) {
      if (event != null) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: page[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Color.fromARGB(255, 199, 199, 199).withOpacity(0.5),
        ),
        child: SizedBox(
          height: MyHomePage.player.currentIndex != null ? 140 : 65,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MyHomePage.player.currentIndex != null ||
                      MyHomePage.player.playing
                  ? InkWell(
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 255, 0, 0),
                                Color.fromARGB(255, 54, 216, 234), 
                              ]),
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: GestureDetector(
                          onHorizontalDragEnd: (DragDownDetails) {
                            if (DragDownDetails.primaryVelocity! < 0) {
                              if (MyHomePage.player.hasNext) {
                                MyHomePage.player.seekToNext();
                                setState(() {});
                              }
                            } else if (DragDownDetails.primaryVelocity! > 0) {
                              if (MyHomePage.player.hasPrevious) {
                                MyHomePage.player.seekToPrevious();
                                setState(() {});
                              }
                            }
                          },
                          child: ListTile(
                            title: SizedBox(
                                child: Marquee(
                              text: Screenplay
                                  .playingdetails![
                                      MyHomePage.player.currentIndex!]
                                  .title,
                              pauseAfterRound: Duration(seconds: 5),
                              velocity: 30,
                            )),
                            leading: CircleAvatar(
                              child: QueryArtworkWidget(
                                  id: Screenplay
                                      .playingdetails![
                                          MyHomePage.player.currentIndex!]
                                      .id,
                                  type: ArtworkType.AUDIO),
                            ),
                            trailing: InkWell(
                                onTap: () async {
                                  if (MyHomePage.player.playing) {
                                    MyHomePage.player.pause();
                                  } else {
                                    if (MyHomePage.player.currentIndex !=
                                        null) {
                                      MyHomePage.player.play();
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: getDecoration(
                                    BoxShape.circle,
                                    const Offset(2, 2),
                                    2.0,
                                    0.0,
                                  ),
                                  child: StreamBuilder<bool>(
                                    stream: MyHomePage.player.playingStream,
                                    builder: (context, snapshot) {
                                      bool? playingstate = snapshot.data;
                                      if (playingstate != null &&
                                          playingstate) {
                                        return Icon(
                                          Icons.pause,
                                          size: 20,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        );
                                      }
                                      return Icon(
                                        Icons.play_arrow,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        size: 20,
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ),
                      ),
                      onTap: () {
                        widget.fianllist!.clear();
                        for (var i = 0;
                            i < Screenplay.playingdetails!.length;
                            i++) {
                          widget.fianllist!.add(Screenplay.playingdetails![i]);
                        }
                        Get.to(()=>Screenplay(songlist: widget.fianllist));
                      },
                    )
                  : SizedBox(
                      height: 0,
                    ),
              NavigationBar(
                backgroundColor: Colors.black,
                animationDuration: const Duration(seconds: 1),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                height: 75,
                selectedIndex: _currentIndex,
                onDestinationSelected: (int newIndext) {
                  setState(() {
                    _currentIndex = newIndext;
                  });
                },
                destinations: [
                  NavigationDestination(
                      selectedIcon: Icon(
                        Icons.home,
                        color: Color.fromARGB(255, 184, 17, 5),
                      ),
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 184, 17, 5),
                      ),
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Icon(
                        Icons.playlist_add,
                        color: Color.fromARGB(255, 184, 17, 5),
                      ),
                      icon: Icon(
                        Icons.playlist_add,
                        color: Colors.white,
                      ),
                      label: ''),
                  NavigationDestination(
                      selectedIcon: Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 184, 17, 5),
                      ),
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      label: ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}