import 'package:firebasechat/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasechat/constants.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return StreamBuilder(
            stream: Firestore.instance
                .collection('/chats')
                .document('uNeOQeyog8rkqByMUYNw')
                .collection('messages')
                .orderBy(
                  'timestamp',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              final documents = snapshot.data.documents;

              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, idx) => MessageBubble(
                  documents[idx]['text'],
                  documents[idx]['userId'] == futureSnapshot.data.uid,
                  documents[idx]['userId'],
                  key: ValueKey(documents[idx].documentID),
                ),
                itemCount: documents.length,
              );
            });
      },
    );
  }
}
