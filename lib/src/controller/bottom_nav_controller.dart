import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';
import 'package:instagram_clone/src/pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVE, MYPAGE }

class BottomNavController extends GetxController{
  static BottomNavController get to => Get.find();
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];


  void _changePage(int value, {bool hasGesture = true}){
    pageIndex(value);
    if(!hasGesture) return;
    if(bottomHistory.contains(value)){
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
  }

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch(page){
      case PageName.UPLOAD:
        Get.to(()=> Upload(), binding: BindingsBuilder(() {
          Get.put(UploadController());
        }) );
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVE:
      case PageName.MYPAGE:
        _changePage(value, hasGesture : hasGesture);
        break;
    }
  }

  Future<bool> willPopAction() async {
    if(bottomHistory.length == 1){
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
            title: '시스템',
            message: '종료하시겠습니까?',
            okCallback: () {
              exit(0);
            },
            cancelCallback: Get.back,
          )
      );
      return true;
    }else{

      var page = PageName.values[bottomHistory.last];
      if(page == PageName.SEARCH){
        var value = await searchPageNavigationKey.currentState!.maybePop(); //pop할게 있으면 true, 없으면 false
        if (value) return false; // willpopAction에서 아무것도 안한다.
      }

      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      return false;
    }
  }
}