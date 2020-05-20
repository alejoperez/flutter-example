import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubbleView extends StatelessWidget {
  final String message;
  final String userName;
  final String imageUrl;
  final bool isMe;
  final Key key;

  MessageBubbleView(
      {@required this.userName,
      @required this.message,
      @required this.imageUrl,
      @required this.isMe,
      @required this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                width: 140,
                decoration: BoxDecoration(
                    color:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(15),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(15),
                    )),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ]),
        Positioned(
            top: 0,
            left: isMe ? null : 120,
            right: isMe ? 120 : null,
            child: CircleAvatar(backgroundImage: NetworkImage(imageUrl),)
        ),

      ],
      overflow: Overflow.visible,
    );
  }
}
