import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/db_functions/databasefavourite.dart';
import 'package:Music_player/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlaylistmodelsAdapter().typeId)) {
    Hive.registerAdapter(PlaylistmodelsAdapter());
  }

  // dbfunctions.getAllsongs();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Screensplah(),
      debugShowCheckedModeBanner: false,
    );
  }
}