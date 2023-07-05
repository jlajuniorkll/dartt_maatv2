import 'package:flutter/material.dart';

class BalloonCard extends StatelessWidget {
  final String title;
  final String message;
  final String dataComentario;
  final bool isMe;

  const BalloonCard({
    required this.title,
    required this.message,
    required this.isMe,
    required this.dataComentario,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isMe ? Colors.lightBlue : Colors.grey.shade200;
    final borderRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          );

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
              Text(
                dataComentario,
                style: const TextStyle(fontSize: 10.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
