import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final SupabaseClient supabase = Supabase.instance.client;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
//  final currentUser = auth.currentUser;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  Future<void> fetchImage() async {
    try {
      final url = await firestore.collection('users').doc(currentUserId).get();
      if (url.exists) {
        setState(() {
          imageUrl = url['photoUrl'];
        });
      } else {
        throw Exception('Could not find image');
      }
    } catch (e) {
      print('Error fetching image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : Text('No image found'),
      ),
    );
  }
}
