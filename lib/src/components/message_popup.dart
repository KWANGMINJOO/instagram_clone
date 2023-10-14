import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopup extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? okCallback;
  final Function()? cancelCallback;

  const MessagePopup({
    super.key,
    required this.title,
    required this.message,
    required this.okCallback,
    this.cancelCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: Get.width * 0.6,
              child: Column(
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: okCallback, child: Text('확인')),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: cancelCallback,
                        child: Text('취소'),
                        style: ElevatedButton.styleFrom(primary: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
