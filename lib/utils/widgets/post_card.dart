import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/components/colors.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1624561172888-ac93c696e10c?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlJTIwYXZhdGFyfGVufDB8fDB8fHww'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
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
                          padding: EdgeInsets.symmetric(vertical: 16),
                          children: ['Delete', 'Restrict', 'Block', 'Report']
                              .map(
                                (element) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
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
                  icon: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHVzZXIlMjBwcm9maWxlJTIwYXZhdGFyfGVufDB8fDB8fHww',
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1,234 likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
