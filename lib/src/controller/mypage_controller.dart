import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData(); // mypage를 모든사람에게 적용하기위함
 }

 void setTargetUser(){
   var uid = Get.parameters['targetUid'];
   if(uid==null){
     targetUser(AuthController.to.user.value);
   }else{
     //TODO 상대 uid로 users collection 조회
   }
 }

 void _loadData(){
   setTargetUser();
   //포스트 리스트 로드
   // 사용자 정보 로드
 }
}