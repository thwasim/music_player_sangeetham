import 'package:Music_player/pages/home/screenplay.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:Music_player/pages/home/homepage.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  ValueNotifier<List<SongModel>> temp = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/Motivational Wallpaper.jpg',
            ),
            fit: BoxFit.cover),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              onTap: () {},
              onChanged: (String? value) {
                if (value == null || value.isEmpty) {
                  temp.value.addAll(MyHomePage.songs);
                }
                temp.value.clear();
                for (SongModel i in MyHomePage.songs) {
                  if (i.title.toLowerCase().contains(value!.toLowerCase())) {
                    temp.value.add(i);
                  }
                  temp.notifyListeners();
                }
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                filled: true,
                errorBorder: InputBorder.none,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ValueListenableBuilder(
                  valueListenable: temp,
                  builder: (BuildContext ctx, List<SongModel> searchData,
                      Widget? chld) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        final data = searchData[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: ListTile(
                            onTap: () {
                              MyHomePage.player.setAudioSource(
                                createPlaylist(searchData),
                                initialIndex: index,
                              );
                              MyHomePage.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      Screenplay(songlist: searchData)));
                            },
                            title: Text(
                              data.title,
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                                child: QueryArtworkWidget(
                              id: data.id,
                              type: ArtworkType.AUDIO,
                              artworkBorder: BorderRadius.circular(0),
                            )),
                          ),
                        );
                      },
                      itemCount: searchData.length,
                    );
                  }),
            ),
          )
        ],
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
