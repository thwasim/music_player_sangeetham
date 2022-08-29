// import 'package:Music_player/db_functions/data_model.dart';
// import 'package:Music_player/pages/home/homepage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistFunctions {

//   static ValueNotifier< List <Playlistmodels>> playlistsong = ValueNotifier([]);


//   static addplaylist({required Playlistmodels model}) async {
//   final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
//   await playlistDB.add(model);
//   getplayList();
//   }
      
//   static getplayList() async {
//     final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
//     playlistsong.value.clear();
//     playlistsong.value.addAll(playlistDB.values);
//     playlistsong.notifyListeners();
//   }

//   static updatlist(index,model)async{
//   final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB');
//   await playlistDB.putAt(index, model);
//   await getplayList();
//   await playlistsongCheck.showselectsong(index); 
//    await getplayList(); 
//  }
   
//     static deleteplaylist(index) async{ 
//     final PlaylistDB =  await Hive.openBox<Playlistmodels>('PlayListsongs_dB'); 
//     await PlaylistDB.deleteAt(index); 
//     getplayList(); 
//   } 
// } 
 
 
// class  playlistsongCheck{
// static ValueNotifier<List<SongModel>> playlistmodel =ValueNotifier([]);
// static ValueNotifier<List> selectplaysong = ValueNotifier([]); 
// static showselectsong(index)async{ 
//   final checksong = PlaylistFunctions.playlistsong.value[index].songlistdb; 
//   selectplaysong.value.clear(); 
//   playlistmodel.value.clear(); 
//   for(int i = 0; i <checksong.length;i++ ){ 
//     for(int j = 0;j < MyHomePage.songs.length;j++){ 
//       if(MyHomePage.songs[j].id == checksong[i]){ 
//        selectplaysong.value.add(j); 
//        playlistmodel.value.add(MyHomePage.songs[j]); 
//         break; 
//       } 
//     } 
//   } 
//  } 
 
//  static reseapp() async{ 
//   final playlistDB = await Hive.openBox<Playlistmodels>('PlayListsongs_dB'); 
//   final boxdb = await Hive.openBox('favourite'); 
//   playlistDB.clear(); 
//   boxdb.clear(); 
//   MyHomePage.player.pause();
//  } 
// } 