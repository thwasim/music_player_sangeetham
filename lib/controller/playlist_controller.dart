import 'package:Music_player/controller/playlistsongcheckcontrller.dart';
import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playlistcontroller extends GetxController {


  List<Playlistmodels> playlistsong = [];
  List<dynamic> songslist = [];
  List<dynamic> updatelist = [];
  List<dynamic> dltlist = [];
  List<SongModel> playlistmodel = [];
  List selectplaysong = [];

  addplaylist({required Playlistmodels model}) async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await playlistDB.add(model);
    getplayList();
  }

  getplayList() async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    playlistsong.clear();
    playlistsong.addAll(playlistDB.values);
    // playlistsong.notifyListeners();
    update();
  }

  updatlist(index, model) async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await playlistDB.putAt(index, model);
    await getplayList();
     Get.find<playlistsongcheckcontrller>().showselectsong(index);
    // await playlistsongCheck.showselectsong(index);
    await getplayList();
  }

  deleteplaylist(index) async {
    final PlaylistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    await PlaylistDB.deleteAt(index);
    getplayList();
  }

  // showselectsong(index) async {
  //   final checksong = PlaylistFunctions.playlistsong[index].songlistdb;
  //   // final checksong = playlistsong[index].songlistdb;
  //   selectplaysong.clear();
  //   playlistmodel.clear();
  //   for (int i = 0; i < checksong.length; i++) {
  //     for (int j = 0; j < MyHomePage.songs.length; j++) {
  //       if (MyHomePage.songs[j].id == checksong[i]) {
  //         selectplaysong.add(j);
  //         playlistmodel.add(MyHomePage.songs[j]);
  //         break;
  //       }
  //     }
  //   }
  // }

  reseapp() async {
    final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
    final boxdb = await Hive.openBox('favourite');
    playlistDB.clear();
    boxdb.clear();
    MyHomePage.player.pause();
  }
}



// class playlistsongCheck {

//   showselectsong(index) async {
//     final checksong = PlaylistFunctions.playlistsong.value[index].songlistdb;
//     selectplaysong.value.clear();
//     playlistmodel.value.clear();
//     for (int i = 0; i < checksong.length; i++) {
//       for (int j = 0; j < MyHomePage.songs.length; j++) {
//         if (MyHomePage.songs[j].id == checksong[i]) {
//           selectplaysong.value.add(j);
//           playlistmodel.value.add(MyHomePage.songs[j]);
//           break;
//         }
//       }
//     }
//   }

//   reseapp() async {
//     final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
//     final boxdb = await Hive.openBox('favourite');
//     playlistDB.clear();
//     boxdb.clear();
//     MyHomePage.player.pause();
//   }
// }
