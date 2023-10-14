import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(10);
    var data = await document.get();
    // 강의와 다름 List<Post>
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}
