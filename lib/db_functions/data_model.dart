
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType (typeId: 1)
class Playlistmodels {
  @HiveField(0)
  String? name;

  @HiveField(1)
 List<dynamic> songlistdb;

  Playlistmodels({this.name,this.songlistdb = const []});
  
}