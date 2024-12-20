// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final   datePublished;
  final String postUrl;
  final String profImage;
  final List likes;
  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Post copyWith({
    String? description,
    String? uid,
    String? postId,
    String? username,
    String? datePublished,
    String? postUrl,
    String? profImage,
    List? likes,
  }) {
    return Post(
      description: description ?? this.description,
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      username: username ?? this.username,
      datePublished: datePublished ?? this.datePublished,
      postUrl: postUrl ?? this.postUrl,
      profImage: profImage ?? this.profImage,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'uid': uid,
      'postId': postId,
      'username': username,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      description: map['description'] as String,
      uid: map['uid'] as String,
      postId: map['postId'] as String,
      username: map['username'] as String,
      datePublished: map['datePublished'] as Timestamp,
      postUrl: map['postUrl'] as String,
      profImage: map['profImage'] as String,
      likes: List.from(
        (map['likes'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(description: $description, uid: $uid, postId: $postId, username: $username, datePublished: $datePublished, postUrl: $postUrl, profImage: $profImage, likes: $likes)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.uid == uid &&
        other.postId == postId &&
        other.username == username &&
        other.datePublished == datePublished &&
        other.postUrl == postUrl &&
        other.profImage == profImage &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        uid.hashCode ^
        postId.hashCode ^
        username.hashCode ^
        datePublished.hashCode ^
        postUrl.hashCode ^
        profImage.hashCode ^
        likes.hashCode;
  }
}
