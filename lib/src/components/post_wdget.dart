import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/image_data.dart';
import 'package:instagram_clone/src/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;
  PostWidget({super.key, required this.post});

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            thumbPath: post.userInfo!.thumbnail!,
            type: AvatarType.TYPE3,
            nickname: post.userInfo!.nickname,
            size: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl: post.thumbnail!);
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 55,
          ),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount??0}개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            post.description??'',
            prefixText: post.userInfo!.nickname,
            onPrefixTap: (){
              print('Dean 페이지로 이동');
            },
            prefixStyle: TextStyle(fontWeight: FontWeight.bold),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: false,
            collapseOnTextTap: false,
            linkColor: Colors.grey,
          )
        ],
      ),
    );
  }

  Widget _replyTextBtn(){
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 000개 모두보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _dateAgo(){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15.0),
    child: Text(
      timeago.format(post.createdAt!),
      style: const TextStyle(
      color: Colors.grey,
      fontSize: 13,
    ),),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          SizedBox(height: 15,),
          _image(),
          SizedBox(height: 15,),
          _infoCount(),
          SizedBox(height: 5,),
          _infoDescription(),
          SizedBox(height: 5,),
          _replyTextBtn(),
          SizedBox(height: 5,),
          _dateAgo(),
        ],
      ),
    );
  }
}
