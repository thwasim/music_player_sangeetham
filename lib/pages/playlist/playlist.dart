import 'package:Music_player/controller/playlist_controller.dart';
import 'package:Music_player/controller/playlistsongcheckcontrller.dart';
import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/pages/playlist/playlist_showsongs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class PlayList extends StatelessWidget {
  PlayList({Key? key, this.addplaylist}) : super(key: key);

  final namecontroller = TextEditingController();

  final playlistcontroller controller = Get.put(playlistcontroller());
  final playlistsongcheckcontrller Playlistsongcheckcontrller =
      Get.put(playlistsongcheckcontrller());

  String? name;
  int? addplaylist;
  @override
  Widget build(BuildContext context) {
    controller.getplayList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text('Playlist')),
      ),
      backgroundColor: Colors.black,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/Motivational Wallpaper.jpg',
                ),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GetBuilder<playlistcontroller>(
                  init: playlistcontroller(),
                  builder: ((controller) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 140,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: controller.playlistsong.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return InkWell(
                                onTap: () {
                                  Get.to(() => PlaylistFolder(
                                        newindex: index,
                                      ));
                                },
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          backgroundColor: Colors.white,
                                          title: Text(
                                            'Delete Folder ${Get.find<playlistcontroller>().playlistsong[index].name} ',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  Get.find<playlistcontroller>()
                                                      .deleteplaylist(index);
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 255, 17, 0),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 168, 168, 168)),
                                        color: Colors.black87),
                                    child: Center(
                                        child: Text(
                                      Get.find<playlistcontroller>()
                                          .playlistsong[index]
                                          .name
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 18),
                                    ))));
                          }),
                    );
                  }),
                ),
              ),
            ],
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(14.0),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    backgroundColor: Colors.black87,
                    content: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: 'Create Folder',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel')),
                          ),
                          TextButton(
                              onPressed: () {
                                if (namecontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Enter Folder Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 17, 0),
                                  ));
                                  Get.back();
                                }
                                if (namecontroller.text.isNotEmpty) {
                                  final name = namecontroller.text;
                                  final model = Playlistmodels(
                                      name: name, songlistdb: []);
                                  Get.find<playlistcontroller>()
                                      .addplaylist(model: model);
                                  Get.back();
                                }
                              },
                              child: const Text('Create')),
                        ],
                      )
                    ],
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
