import 'package:Music_player/controller/favourte_controller.dart';
import 'package:Music_player/controller/playlist_controller.dart';
import 'package:Music_player/pages/favourtie/favouritebutton.dart';
import 'package:Music_player/pages/home/contact.dart';
import 'package:Music_player/pages/home/screenplay.dart';
import 'package:Music_player/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  static List<SongModel> songs = [];

  static final AudioPlayer player = AudioPlayer();

   MyHomePage({Key? key,}) : super(key: key);

  FavourtieController favcontroller = Get.put(FavourtieController());
  @override
  State<MyHomePage> createState() => _MyHomePage();
}

@override
State<MyHomePage> createState() => _MyHomePage();

class _MyHomePage extends State<MyHomePage> {
  //define on audio plugin
  final OnAudioQuery _audioQuery = OnAudioQuery();
  //player the song
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  String currentSongTitle = '';
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // dbfunctions.displaySongs();
    return Scaffold(  
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text("LYRIC",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    background: Image.asset(
                      "assets/assa.webp",
                      fit: BoxFit.cover,
                    ))),
          ];
        },
        body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (item.data!.isEmpty) {
              return Center(
                child: Text(
                  "NO SONGS",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            }

            MyHomePage.songs = item.data!;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/Motivational Wallpaper.jpg',
                      ),
                      fit: BoxFit.cover)),
              child: ListView.builder(
                  itemCount: item.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, left: 12, right: 16),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: ListTile(
                          title: Text(
                            item.data![index].title,
                            style: TextStyle(color: Colors.white),
                            maxLines: 2,
                          ),
                          trailing: FavFunction(index: index),
                          leading: QueryArtworkWidget(
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                          onTap: () async {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (ctx) => Screenplay(
                                          songlist: MyHomePage.songs,
                                        )))
                                .then((_) {
                              setState(() {});
                            });
                            await MyHomePage.player.setAudioSource(
                                createPlaylist(item.data!),
                                initialIndex: index);
                            await MyHomePage.player.play();
                          },
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: Text("Home"),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contacts,
                color: Colors.green,
              ),
              title: Text("Contact Us"),
              onTap: () {
                Get.to(() => UserDetails());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.restart_alt,
                color: Colors.green,
              ),
              title: Text("App Restart"),
              onTap: () {
                Get.defaultDialog(
                  title: 'Restart App',
                  middleText: '',
                  textCancel: 'Cancel',
                  cancelTextColor: Colors.black,
                  textConfirm: 'Delete',
                  confirmTextColor: Colors.black,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    Get.find<playlistcontroller>().reseapp();
                    Get.offAll(Screensplah());
                  },
                );
              },
            ),
            SizedBox(
              height: 230,
            ),
            Divider(
              color: Colors.black,
              thickness: 3,
            ),
            ListTile(
              leading: Icon(
                Icons.smart_toy_outlined,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              title: Text("Version"),
              trailing: Text(
                '0.01',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!),
          tag: MediaItem(id: song.id.toString(), title: song.title)));
    }
    return ConcatenatingAudioSource(children: sources);
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  BoxDecoration getDecoration(BoxShape boxShape, Offset offset,
      double blurRadius, double spreadRadius) {
    return BoxDecoration(
        color: Color.fromARGB(255, 99, 90, 8), shape: BoxShape.circle);
  }
}

// time duration class
class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
