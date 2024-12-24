import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/utils/components/colors.dart';
import 'package:instagram_clone/utils/components/global_variables.dart';
import 'package:instagram_clone/utils/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
      final width= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: width > webScreenSize ? webBackgroundColor: mobileBackgroundColor,
      appBar:width > webScreenSize? null : AppBar(
        forceMaterialTransparency: true,
        title: SvgPicture.asset(
          'asset/images/Instagram-logo-text.svg',
          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          height: 52,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('datePublished', descending: true).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          final posts = snapshot.data!.docs.map((doc) {
            return Post.fromMap(doc.data());
          }).toList();
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: width > webScreenSize? width *0.3 : 0, vertical: width > webScreenSize? 15 : 0),
                child: PostCard(
                  snap: posts[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
