import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
        itemCount: 10,
      ),
    );
  }
}
