import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final commentPost;
  const CommentCard({super.key, required this.commentPost});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
   @override
  Widget build(BuildContext context) {
    Timestamp timeStamp = widget.commentPost['date'];
    DateTime dateTime = timeStamp.toDate();
    String formattedDate = DateFormat.yMMMd().format(dateTime);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.commentPost['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.commentPost['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.commentPost['text']}',
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(formattedDate,
                       style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite_border,
            ),
          ),
        ],
      ),
    );
  }
}
