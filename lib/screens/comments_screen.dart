import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/components/colors.dart';
import 'package:instagram_clone/utils/widgets/comment_card.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  final comment;
  const CommentsScreen({
    super.key,
    this.comment,
  });

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: widget.comment?.postId! != null
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.comment.postId)                  .collection('comments')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Be the first to comment'),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        commentPost: snapshot.data!.docs[index].data(),
                      );
                    });
              })
          : const Text('Unable to load comments'),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentsController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                    widget.comment.postId,
                    _commentsController.text.trim(),
                    user.uid,
                    user.username,
                    widget.comment.profImage,
                  );
                  setState(() {
                    _commentsController.clear();
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
