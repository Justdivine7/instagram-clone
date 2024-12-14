import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/image_picker.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;
  bool isLoading = false;
  Future selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(
          file: _file!,
          description: _descriptionController.text.trim(),
          uid: uid,
          username: username,
          profImage: profImage);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload successful'),
        ),
      );
      _descriptionController.clear();
      clearImage();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload post'),
        ),
      );
      _descriptionController.clear();

      print(e);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final UserData? user = ref.watch(userProvider);
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () {
                selectImage(context);
              },
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(user!.uid, user.username, user.photoUrl);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? LinearProgressIndicator()
                    : SizedBox(
                        height: 1,
                      ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: _file != null
                          ? NetworkImage(user!.photoUrl)
                          : NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1732757787074-0f95bf19cf73?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dXNlciUyMHByb2ZpbGUlMjBhdmF0YXJ8ZW58MHx8MHx8fDA%3D'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: _file != null
                                  ? MemoryImage(_file!)
                                  : NetworkImage(
                                      'https://plus.unsplash.com/premium_photo-1732757787074-0f95bf19cf73?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dXNlciUyMHByb2ZpbGUlMjBhdmF0YXJ8ZW58MHx8MHx8fDA%3D',
                                    ),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ));
  }
}
