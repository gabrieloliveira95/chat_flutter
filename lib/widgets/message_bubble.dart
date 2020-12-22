import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final String userName;
  final bool belongsToMe;
  final String image;
  final Key key;
  MessageBubble(this._message, this.userName, this.image, this.belongsToMe,
      {this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToMe
                    ? Colors.grey[300]
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      belongsToMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight:
                      belongsToMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: belongsToMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: belongsToMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                      color: belongsToMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: belongsToMe ? TextAlign.end : TextAlign.start,
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToMe ? null : 128,
          right: belongsToMe ? 128 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
      ],
    );
  }
}
