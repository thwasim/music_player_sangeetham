
import 'package:Music_player/controller/playlist_controller.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class playlistsongcheckcontrller extends GetxController{
  

   List<SongModel> playlistmodel = [];
   List selectplaysong = []; 

   

 showselectsong(index)async{ 
  final checksong =  Get.find<playlistcontroller>().playlistsong[index].songlistdb; 
  selectplaysong.clear(); 
  playlistmodel.clear(); 
  for(int i = 0; i <checksong.length;i++ ){ 
    for(int j = 0;j < MyHomePage.songs.length;j++){ 
      if(MyHomePage.songs[j].id == checksong[i]){ 
       selectplaysong.add(j); 
       playlistmodel.add(MyHomePage.songs[j]); 
        break; 
      } 
    } 
  } 
 } 
} 
