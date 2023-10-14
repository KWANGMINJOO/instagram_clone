import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/components/post_wdget.dart';
import 'package:instagram_clone/src/controller/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbPath:
              'https://h5p.org/sites/default/files/h5p/content/1209180/images/file-6113d5f8845dc.jpeg',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(
          width: 5,
        ),
        _myStory(),
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
            100,
            (index) => AvatarWidget(
                thumbPath:
                    'https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg',
                type: AvatarType.TYPE1)),
      ]),
    );
  }

  Widget _postList(){
    return Obx(()=>Column(
      children: List.generate(
          controller.postList.length,
              (index) => PostWidget(post : controller.postList[index])
      ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
              children: [
                _storyBoardList(),
                _postList(),
              ],
          ),
    );
  }
}
