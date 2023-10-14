import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class UserRepository {
  static Future<IUser?> loginUserByUid(String uid) async {
    print(uid);
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if(data.size == 0){
      return null;//bool이 반환되는데 null이 올수도있다 bool?
    }else{
      return IUser.fromJson(data.docs.first.data());

    }
  }

  static Future<bool> signup(IUser user) async{
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    }catch(e){
      return false;
    }
  }
}
