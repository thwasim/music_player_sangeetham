// import 'package:Music_player/controller/favourte_controller.dart';
// import 'package:Music_player/pages/home/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class FavFunction extends StatelessWidget {
//   FavFunction(  {Key? key,required this.index,}) : super(key: key);
//   int index;
  
// // final SongModel song;

//   FavourtieController favcontroller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     int id=MyHomePage.songs[index].id;
//     final finalIndex = favcontroller.favsongids .indexWhere((element) => element == MyHomePage.songs[index].id);
//     bool indexCheck = favcontroller.favouritesongs.contains(id);
//     if (indexCheck == true) {
//       return IconButton(
//           onPressed: () async {
//             await favcontroller.deletefav(finalIndex);
//             favcontroller.getAllsongs();
//              indexCheck = favcontroller.favouritesongs.contains(index);
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 backgroundColor: Color.fromARGB(255, 94, 90, 90),
//                 duration: Duration(milliseconds: 190),
//                 content: Text('Removed from Liked Songs'),
//                 margin: EdgeInsets.all(20),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           },
//           icon: const Icon(
//             Icons.favorite,
//             color: Color.fromARGB(255, 255, 17, 0),
//             size: 30,
//           ));
//     }else{
//       return IconButton(
//       onPressed: () async {
//         await favcontroller.addsong(MyHomePage.songs[index].id);
//         await favcontroller.getAllsongs();
        
//          indexCheck = favcontroller.favouritesongs.contains(index);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           duration: Duration(milliseconds: 190),
//           backgroundColor: Color.fromARGB(255, 94, 90, 90),
//           content: Text(
//             'added to Liked Songs',
//             style: TextStyle(color: Colors.white),
//           ),
//           margin: EdgeInsets.all(20),
//           behavior: SnackBarBehavior.floating,
//         ));
//       },
//       icon: const Icon(
//         Icons.favorite_border,
//         color: Color.fromARGB(255, 255, 0, 0),
//         size: 35,
//       ),
//     );
//     }
    
//   }
// }


import 'package:Music_player/pages/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/favourte_controller.dart';

// ignore: must_be_immutable
class FavFunction extends StatefulWidget {
  FavFunction({Key? key, this.index}) : super(key: key);

  dynamic index;

  @override
  State<FavFunction> createState() => _FavFunctionState();
}

class _FavFunctionState extends State<FavFunction> {

   FavourtieController favcontroller = Get.find();
  
  @override
  Widget build(BuildContext context) {
    final finalIndex = favcontroller.favsongids
        .indexWhere((element) => element == MyHomePage.songs[widget.index!].id);
    final indexCheck = favcontroller.favouritesongs.contains(widget.index);
    if (indexCheck == true) {
      return IconButton(
          onPressed: () async {
            await favcontroller.deletefav(finalIndex);
            // favcontroller.getAllsongs;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 94, 90, 90),
              duration: Duration(milliseconds: 190),
              content: Text('Removed from Liked Songs'),
              margin: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
            ));
          },
          icon: const Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 255, 17, 0),
            size: 30,
          ));
    }
    return IconButton(
      onPressed: () async {
        await favcontroller.addsong(MyHomePage.songs[widget.index!].id);
        // await favcontroller.getAllsongs();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 190),
          backgroundColor: Color.fromARGB(255, 94, 90, 90),
          content: Text(
            'added to Liked Songs',
            style: TextStyle(color: Colors.white),
          ),
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      },
      icon: const Icon(
        Icons.favorite_border,
        color: Color.fromARGB(255, 255, 0, 0),
        size: 35,
      ),
    );
  }
}