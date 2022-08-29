// import 'package:Music_player/pages/home/homepage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class dbfunctions{

//   static ValueNotifier<List<dynamic>> favouritesongs = ValueNotifier([]);
//   static ValueNotifier<List<SongModel>> favsongmodel = ValueNotifier([]);
  
//   // var studentlist = RxList<Studentmodel>([]).obs;


//   static List<dynamic> favsongids=[];

//   static addsong(item) async {
//     final boxdb = await Hive.openBox('favourite');
//     await boxdb.add(item);
//     favsongids.add(item);
//     getAllsongs();
//   }

//   static getAllsongs() async {
//     favsongids.clear();
//     final boxdb = await Hive.openBox('favourite');
//     favsongids = boxdb.values.toList();
//     displaySongs();
//     favouritesongs.notifyListeners();
//   }

//   static deletefav(index) async {
//     var boxdb = await Hive.openBox('favourite');
//     await boxdb.deleteAt(index);
//     getAllsongs();
//   }

//   static displaySongs() async {
//     final boxdb = await Hive.openBox('favourite');
//     final dynamic music = boxdb.values.toList();
//     favouritesongs.value.clear();
//     favsongmodel.value.clear();
//     for (int i = 0; i < music.length; i++) {
//       for (int j = 0; j < MyHomePage.songs.length; j++) {
//         if (music[i] == MyHomePage.songs[j].id) {
//           favouritesongs.value.add(j);
//           favsongmodel.value.add(MyHomePage.songs[j]);
//         }
//       }
//     }
//   }
 
// }

