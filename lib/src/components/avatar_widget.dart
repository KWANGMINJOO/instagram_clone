import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum AvatarType {TYPE1, TYPE2, TYPE3}

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String thumbPath;
  String? nickname;
  AvatarType type;
  double? size;

  AvatarWidget({
    super.key,
    required this.thumbPath,
    required this.type,
    this.hasStory,
    this.nickname,
    this.size = 65,
    });

  Widget type1Widget(){
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size!),
          child: SizedBox(
            width: size,
            height: size,
            child: CachedNetworkImage(
              imageUrl: thumbPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
  Widget type2Widget(){
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget type3Widget(){
    return Row(
      children: [
        type1Widget(),
        Text(
          nickname??'', // 닉네임이 만약 null 이면 빈값 ''을 줌
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),)
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    switch(type){
      case AvatarType.TYPE1:
        return type1Widget();
        break;
      case AvatarType.TYPE2:
        return type2Widget();
        break;
      case AvatarType.TYPE3:
        return type3Widget();
        break;
    }

  }
}
