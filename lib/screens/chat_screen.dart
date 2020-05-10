import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/uNeOQeyog8rkqByMUYNw/messages')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final documents = snapshot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[idx]['text']),
              key: documents[idx]['id'],
            ),
            itemCount: documents.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/uNeOQeyog8rkqByMUYNw/messages')
              .add({'text': 'Test message'});
        },
      ),
    );
  }
}
