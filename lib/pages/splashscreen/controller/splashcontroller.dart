import 'package:Music_player/home.dart';
import 'package:get/get.dart';

class splashcontroller extends GetxController{
  @override
  void onInit() {
      gohome();
    super.onInit();
  }

   Future<void> gohome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off( MyHomePages());
  }
}