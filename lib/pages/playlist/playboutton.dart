import 'package:Music_player/controller/playlist_controller.dart';
import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PlaylistButton extends StatefulWidget {
  PlaylistButton(
      {Key? key,
      required this.index,
      required this.folderindex,
      required this.songindex})
      : super(key: key);
  int? index;
  int? folderindex;
  int? songindex;
  List<dynamic> songslist = [];
  static List<dynamic> updatelist = [];
  static List<dynamic> dltlist = [];
  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  @override
  Widget build(BuildContext context) {
    final playlitsfunctions = Get.find<playlistcontroller>();
   
    final checkindex =  Get.find<playlistcontroller>().playlistsong[widget.folderindex!].songlistdb
        .contains(widget.songindex);
    final indexcheck = playlitsfunctions
        .playlistsong[widget.folderindex!].songlistdb
        .indexWhere((element) => element == MyHomePage.songs[widget.index!].id);
    if (checkindex != true) {
      return IconButton(
          onPressed: () async {
            widget.songslist.add(MyHomePage.songs[widget.index!].id);
            PlaylistButton.updatelist = [
              widget.songslist,
              playlitsfunctions
                  .playlistsong[widget.folderindex!].songlistdb
            ].expand((element) => element).toList();
            final model = Playlistmodels(
              name: playlitsfunctions
                  .playlistsong[widget.folderindex!].name,
              songlistdb: PlaylistButton.updatelist,
            );
            await playlitsfunctions.updatlist(widget.folderindex, model);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 2),
                content: Text(
                  'Add Song Floder',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(
            Icons.add_circle_outlined,
            color: Colors.white,
          ));
    }
    return IconButton(
        onPressed: () async {
          playlitsfunctions.playlistsong[widget.folderindex!].songlistdb
              .removeAt(indexcheck);
          PlaylistButton.dltlist = [
            widget.songslist,
            playlitsfunctions.playlistsong[widget.folderindex!].songlistdb
          ].expand((element) => element).toList();
          final model = Playlistmodels(
              name: playlitsfunctions
                  .playlistsong[widget.folderindex!].name,
              songlistdb: PlaylistButton.dltlist);
          await playlitsfunctions.updatlist(widget.folderindex, model);
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text(
                'Song Remove Floder',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromARGB(255, 68, 68, 68),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: Icon(
          Icons.check_circle,
          color: Color.fromARGB(255, 255, 0, 0),
        ));
  }
}
