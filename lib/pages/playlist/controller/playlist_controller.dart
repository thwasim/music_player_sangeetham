import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playlistcontroller extends GetxController {


  List<Playlistmodels> playlistsong = [];
  List<SongModel> playlistmodel = [];
  List selectplaysong = [];

  addplaylist({required Playlistmodels model}) async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await playlistDB.add(model);
    getplayList();
    update();
  }

  getplayList() async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    playlistsong.clear();
    playlistsong.addAll(playlistDB.values);
    update();
    
  }

  updatlist(index, model) async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await playlistDB.putAt(index, model);
    await getplayList();
     showselectsong(index);
    update();
  }


   showselectsong(index)async{ 
  final checksong =  Get.find<playlistcontroller>().playlistsong[index].songlistdb; 
  playlistmodel.clear(); 
  for(int i = 0; i <checksong.length;i++ ){ 
    for(int j = 0;j < MyHomePage.songs.length;j++){ 
      if(MyHomePage.songs[j].id == checksong[i]){ 
       playlistmodel.add(MyHomePage.songs[j]); 
        break; 
      } 
    } 
  } update();
 } 


  deleteplaylist(index) async {
    final PlaylistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await PlaylistDB.deleteAt(index);
    getplayList();
  }

  reseapp() async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    final boxdb = await Hive.openBox('favourite');
    playlistDB.clear();
    boxdb.clear();
    MyHomePage.player.pause();
    update();
  }
}
