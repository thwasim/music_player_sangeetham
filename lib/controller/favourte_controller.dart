import 'package:Music_player/pages/home/homepage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavourtieController extends GetxController{

  FavourtieController(){
    getAllsongs();
  }

  // static ValueNotifier<List<dynamic>> favouritesongs = ValueNotifier([]);
   List<SongModel> favsongmodel = [];
  
  List <SongModel> favouritesongs = [];
   List<dynamic> favsongids=[];

   addsong(item) async {
    final boxdb = await Hive.openBox('favourite');
    await boxdb.add(item);
    favsongids.add(item);
    getAllsongs();
    update();
  }

   getAllsongs() async {
    favsongids.clear();
    final boxdb = await Hive.openBox('favourite');
    favsongids = boxdb.values.toList();
    displaySongs();
    update();
  }

   deletefav(index) async {
    var boxdb = await Hive.openBox('favourite');
    await boxdb.deleteAt(index);
    getAllsongs();
    update();
  }

   displaySongs() async {
    final boxdb = await Hive.openBox('favourite');
    final  music = boxdb.values.toList();
    favouritesongs.clear();
    for(int i =0; i< MyHomePage.songs.length; i++){
      for(int j=0 ; j< music.length ;j++){
        if (music[j] == MyHomePage.songs[i].id) {
          favouritesongs.add(MyHomePage.songs[i]);
        }
      }
    }
   update();
  }
}