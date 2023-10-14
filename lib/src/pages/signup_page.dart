import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class SignupPage extends StatefulWidget {
  final String uid;

  const SignupPage({super.key, required this.uid});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile;

  void update() => setState(() {});

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: SizedBox(
            width: 150,
            height: 150,
            child: thumbnailXFile!=null? Image.file(File(thumbnailXFile!.path), fit: BoxFit.fill,) :Image.asset(
              'assets/images/default_image.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () async {
              thumbnailXFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10); //image quality 조절 필요 maxHeight 등
              update();
            },
            child: Text(
              '이미지 변경',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ))
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            _avatar(),
            const SizedBox(
              height: 30,
            ),
            _nickname(),
            const SizedBox(
              height: 30,
            ),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            // validation 필요, 닉네임은 영어만 등
            var signupUser = IUser(
                nickname: nicknameController.text,
                description: descriptionController.text,
                uid: widget.uid);
            AuthController.to.signup(signupUser, thumbnailXFile);
          },
          child: const Text('회원가입'),
        ),
      ),
    );
  }
}
