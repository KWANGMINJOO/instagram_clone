import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends GetView<UploadController> {
  Upload({super.key});

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _loadPhotos();
  // }

  // void update() => setState(() {});

  Widget _imagePreview() {
    // var width = MediaQuery.of(context).size.width;
    print(controller.selectedImage.value.type);
    var width = Get.width;
    return Obx(() => Container(
          width: width,
          height: width,
          color: Colors.grey,
          child:
          _photoWidget(controller.selectedImage.value, width.toInt(),
              builder: (data) {
            return Image.memory(
              data,
              fit: BoxFit.cover,
            );
          }),
        )
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: Get.context!,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(Get.context!).size.height / 3,
                  ),
                  builder: (_) => Container(
                        // height: 200,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black54,
                                  ),
                                  width: 40,
                                  height: 4,
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(
                                      controller.albums.length,
                                      (index) => GestureDetector(
                                        onTap:(){
                                          controller.changeAlbum(controller.albums[index]);
                                          Get.back();
                                        },
                                        child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 20),
                                              child: Text(
                                                  controller.albums[index].name),
                                            ),
                                      )),
                                ),
                              ))
                            ]),
                      )

              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Obx(()=>Text(
                    controller.headerTitle.value,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(()=>GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1, // 정사각형 :1
        ),
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _photoWidget(controller.imageList[index], 200,
              builder: (data) {
            return GestureDetector(
                onTap: () {
                  controller.changeSelectedImage(controller.imageList[index]);
                },
                child: Obx(
                  () => Opacity(
                    opacity: controller.imageList[index] ==
                            controller.selectedImage.value
                        ? 0.3
                        : 1,
                    child: Image.memory(
                      data,
                      fit: BoxFit.cover,
                    ),
                  ),
                ));
          });
        }
      ),
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
        future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage,
            ),
          ),
        ),
        title: Text(
          'New post',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
