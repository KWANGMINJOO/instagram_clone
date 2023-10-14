import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:instagram_clone/src/pages/active_history.dart';
import 'package:instagram_clone/src/pages/home.dart';
import 'package:instagram_clone/src/pages/mypage.dart';
import 'package:instagram_clone/src/pages/search.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction,
        child: Obx(
          () => Scaffold(
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                const Home(),
                Navigator(
                  key: controller.searchPageNavigationKey,
                  onGenerateRoute: (routeSetting){
                    return MaterialPageRoute(builder: (context)=> const Search());
                  },
                ),
                Container(),
                const ActiveHistory(),
                const MyPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              onTap: controller.changeBottomNav,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff), //svg files 사용 필요
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'upload',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'active',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  label: 'my',
                ),
              ],
            ),
          ),
        ),
    );
  }
}
