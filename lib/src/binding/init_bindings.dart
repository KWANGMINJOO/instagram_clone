import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:instagram_clone/src/controller/home_controller.dart';
import 'package:instagram_clone/src/controller/mypage_controller.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';

// App 실행 시 GetX의 controller를 instance로 올려주기 위함
class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true); // App이 종료될때까지 controller를 살려놓음
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding(){
    Get.put(MypageController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }

}