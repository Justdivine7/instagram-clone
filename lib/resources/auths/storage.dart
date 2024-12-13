import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
 import 'package:supabase_flutter/supabase_flutter.dart';

class StorageMethods {
  final SupabaseClient supabase = Supabase.instance.client;
  Future<String> uploadImageToSupabase({
    required Uint8List file,
    required String bucketName,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User is not aunthenticated");
      }
      final String uid = currentUser.uid;
      final String fileName = 'profile-images/$uid-profile-pic.jpg';
      final filePath =
          await supabase.storage.from(bucketName).uploadBinary(fileName, file);
      if (filePath.isEmpty) {
        throw Exception('Failed to upload file to supabase');
      }
      final publicUrl =
          supabase.storage.from(bucketName).getPublicUrl(fileName);

      if (publicUrl.isEmpty) {
        throw Exception('Failed to generate public URL for the image.');
      }
      return publicUrl;
    } catch (err) {
      throw Exception("Error uploading image: $err");
    }
  }
}
