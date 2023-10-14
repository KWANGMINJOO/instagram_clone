import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/components/user_card.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/controller/mypage_controller.dart';

class MyPage extends GetView<MypageController> {
  const MyPage({super.key});


  Widget _statisticOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 10, color: Colors.black),
        )
      ],
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Obx(()=>Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarWidget(
                thumbPath:
                    controller.targetUser.value.thumbnail!,
                type: AvatarType.TYPE3,
                size: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _statisticOne('Post', 15)),
                    Expanded(child: _statisticOne('Followers', 11)),
                    Expanded(child: _statisticOne('Following', 13)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            controller.targetUser.value.description!,
            style: TextStyle(fontSize: 13, color: Colors.black),
          )
        ],
      ),
      )
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: Color(0xffdedede),
                )),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          )),
          SizedBox(
            width: 8,
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(IconsPath.addFriend),
          )
        ],
      ),
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: List.generate(
                    10,
                    (index) =>
                        UserCard(
                            userId: '개념$index',
                            description: '개념e$index님이 팔로우 합니다.'))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu(){
    return TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        tabs: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ImageData(IconsPath.gridViewOn),
      ),
      Container(
        child: ImageData(IconsPath.myTagImageOn),
      )
    ]);
  }

  Widget _tabView(){
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ), itemBuilder: (BuildContext context, int index){
          return Container(
            color: Colors.grey,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Obx(()=>Text(
          controller.targetUser.value.nickname!,
          //AuthController.to.user.value.nickname!,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            SizedBox(height: 20,),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}
