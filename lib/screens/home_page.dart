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

  Future<String?> fetchImage() async {
    try {
      final url = await firestore.collection('users').doc(currentUserId).get();
      final data = url.data();
      if (data != null) {
        return data['photoUrl'];
      } else {
        throw Exception('Could not find image');
      }
    } catch (e) {
      print('Error fetching image:$e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: fetchImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('loading'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No image found'));
          }
          return Center(child: Image.network(snapshot.data!));
        },
      ),
    );
  }
}
