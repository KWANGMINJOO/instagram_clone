import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';
import 'package:instagram_clone/src/pages/login.dart';
import 'package:instagram_clone/src/pages/signup_page.dart';

class Root extends GetView<AuthController>{
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user){
        if(user.hasData){
          // TODO : 내부 데이터베이스 유저 정보 조회 with user.data.uid
          return FutureBuilder<IUser?>(
              future: controller.loginUser(user.data!.uid), //GetX 영상 참조
              builder: (context, snapshot){
                if(snapshot.hasData){
                return const App();
                }else{
                  return Obx(
                        ()=> controller.user.value.uid != null
                            ? const App()
                            : SignupPage(uid : user.data!.uid),);
                }
          });
        }else{
        return const Login();
        }
        });
  }
}
