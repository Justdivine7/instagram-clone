import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/screens/comments_screen.dart';
import 'package:instagram_clone/utils/components/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends ConsumerStatefulWidget {
  final snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  int comment = 0;
  StreamSubscription<int>? commentLength;
  void getComments() {
    commentLength = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap.postId)
        .collection('comments')
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .listen((count) {
      setState(() {
        comment = count;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(widget.snap.profImage),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          children: [
                            'Delete',
                          ]
                              .map(
                                (element) => InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await FirestoreMethods().deletePost(
                                      widget.snap.postId,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(element),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: double.infinity,
            child: Image.network(
              widget.snap.postUrl,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                      widget.snap.postId,
                      user!.uid,
                      widget.snap.likes,
                    );
                  },
                  icon: widget.snap!.likes.contains(user?.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        )),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        comment: widget.snap,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap.likes.length} likes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.snap.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap.description}',
                        ),
                        // TextSpan(
                        //   text: '...',
                        //   style: TextStyle(
                        //     color: primaryColor,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: '3 days ago',
                        //   style: TextStyle(
                        //     color: secondaryColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommentsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      'View all $comment comments',
                      style: const TextStyle(color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap.datePublished.toDate(),
                    ),
                    style: const TextStyle(color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
