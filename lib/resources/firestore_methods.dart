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
      String postId = const Uuid().v1();
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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid,
      String username, String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'text': text,
          'uid': uid,
          'username': username,
          'profilePic': profilePic,
          'commentId': commentId,
          'date': DateTime.now(),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }
  //   Future<int> getComments(String postId) async {
  //   try {
  // final comment =  _firestore.collection('posts').doc(postId).collection('comments').get();
  //     return comment.docs.length;
  //   } catch (err) {
  //     print(err.toString());
  //   }
  // }

  Future<void> followUser(
    String followerId,
    String uid,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followerId)) {
        await _firestore.collection('users').doc(followerId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followerId])
        });
      }else{
        await _firestore.collection('users').doc(followerId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followerId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
  
}
