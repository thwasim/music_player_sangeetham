import 'package:Music_player/controller/favourte_controller.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:Music_player/pages/home/screenplay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouritePage extends StatelessWidget {
   FavouritePage({Key? key}) : super(key: key);

 
   FavourtieController favcontroller = Get.put(FavourtieController());

  @override
  Widget build(BuildContext context) {
    // dbfunctions.favouritesongs;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/Motivational Wallpaper.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            AppBar(
                backgroundColor: Colors.black,
                title: Center(child: Text('Favourite'))),
            GetBuilder<FavourtieController>(
                builder:(controller) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount:controller.favouritesongs.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: ListTile(
                            onTap: () async {
                              Get.to(() => Screenplay(
                                    songlist: favcontroller.favouritesongs ,
                                  ));
                              await MyHomePage.player.setAudioSource(
                                  createPlaylist(
                                      controller.favouritesongs),
                                  initialIndex: index);
                              await MyHomePage.player.play();
                            },
                            contentPadding: EdgeInsets.all(10),
                            leading: QueryArtworkWidget(
                                id: favcontroller.favouritesongs[index].id,
                                type: ArtworkType.AUDIO),
                            title: Text(
                              favcontroller.favouritesongs [index].title,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          title: Text(
                                            'Remove From Favouite',
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'Cancel',
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  controller.deletefav(index);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        duration: Duration(
                                                            milliseconds: 190),
                                                        content: Text(
                                                            'Removed This Songs'),
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating),
                                                  );
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'Remove',
                                                )),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 32,
                                  color: Color.fromARGB(255, 255, 17, 0),
                                )),
                          ),
                        ),
                      );
                    },
                  ));
                }),
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
}
