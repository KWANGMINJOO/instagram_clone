import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/binding/init_bindings.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;

  Future<IUser?> loginUser(String uid)async{
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    if(userData!=null){
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void signup(IUser signupUser, XFile? thumbnail) async{
    if(thumbnail == null){
      _submitSignup(signupUser);
    }else{
      //파일 validation 확장자 있는지
      var task = uploadXFile(thumbnail, '${signupUser.uid}/profile.${thumbnail.path.split('.').last}');
      task.snapshotEvents.listen((event) async {
        print(event.bytesTransferred);
        if(event.bytesTransferred == event.totalBytes && event.state == TaskState.success){
          var downloadUrl = await event.ref.getDownloadURL();
          //signupUser.thumbnail = downloadUrl; // 언제 참조가 될지 모름 ,  mutable immutable
          var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
          _submitSignup(updatedUserData);
        }
      });
    }

  }

  UploadTask uploadXFile(XFile file, String filename){
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},);
    return ref.putFile(f, metadata);
  }

  void _submitSignup(IUser signupUser) async{
    var result = await UserRepository.signup(signupUser);
    if(result){
      loginUser(signupUser.uid!);
//      user(signupUser);
    }
  }

}