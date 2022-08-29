import 'package:Music_player/controller/playlistsongcheckcontrller.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:Music_player/pages/playlist/playboutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Screen_playlist extends StatefulWidget {
  Screen_playlist({Key? key,required this.modelindex}) : super(key: key);

  int modelindex;

  @override
  State<Screen_playlist> createState() => _Screen_playlistState();
}

class _Screen_playlistState extends State<Screen_playlist> {
  @override
  Widget build(BuildContext context) {
    Get.find<playlistsongcheckcontrller>().showselectsong(widget.modelindex);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            'SELECT THE SONGS ',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Motivational Wallpaper.jpg'),
                  fit: BoxFit.cover)),
          child: ListView.builder(
              itemCount: MyHomePage.songs.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30, left: 12, right: 16),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 2, color: Colors.white),
                    ),  
                    child: ListTile(
                      title: Text(
                        MyHomePage.songs[index].title,style: TextStyle(color: Colors.white),
                        maxLines: 2,
                      ),
                      trailing: PlaylistButton(
                        index: index,
                        songindex: MyHomePage.songs[index].id,
                        folderindex: widget.modelindex,
                      ),
                      leading: QueryArtworkWidget(
                        id: MyHomePage.songs[index].id,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
