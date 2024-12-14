import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/auths/storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required Uint8List file,
    required String description,
    required String uid,
    required String username,
    required String profImage,
  }) async {
    String res = 'Some error occured';
    try {
      String postId = Uuid().v1();
      String photoUrl = await StorageMethods().uploadImageToSupabase(
          file: file,
          bucketName: 'images',
          isPost: true,
          fileName: 'post_media/$postId.jpg');
      Post post = Post(
        description: description,
        uid: uid,
        postId: postId,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      await _firestore.collection('posts').doc(postId).set(post.toMap());
      return res = 'Post uploaded successfully';
    } catch (err) {
      res = err.toString();
      print('Error: $err');
      throw Exception(err.toString);
    }
  }
}
