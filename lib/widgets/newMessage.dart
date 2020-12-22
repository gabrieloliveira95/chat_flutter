import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _message = '';
  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final _user = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _message,
      'date': DateTime.now(),
      'userId': user.uid,
      'userName': _user.get('name'),
      'userImage': _user.get('imageUrl'),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send Message'),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
