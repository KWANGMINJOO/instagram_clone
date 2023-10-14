import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;
  const UserCard({super.key, required this.userId, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black12,
        )
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(height: 10,),
                AvatarWidget(
                    thumbPath:'https://www.kagoshima-kankou.com/storage/tourism_themes/12/responsive_images/ElwnvZ2u5uZda7Pjcwlk4mMtr08kLNydT8zXA6Ie__1673_1115.jpeg',
                    type: AvatarType.TYPE2,
                size: 80,),
                const SizedBox(height: 10,),
                Text(userId, style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description,style: TextStyle(
                  fontSize: 11,
                ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(onPressed: (){}, child: const Text('Follow')),
              ],
            ),
          ),
            Positioned(
                right: 5,
                top: 5,
                child: GestureDetector(
                    onTap: (){},
                    child: const Icon(Icons.close, size: 14, color: Colors.grey,),
                ),
            ),
        ],
      ),
    );
  }
}
