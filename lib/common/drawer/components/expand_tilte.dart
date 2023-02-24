import 'package:flutter/material.dart';

class ExpandTile extends StatelessWidget {
  const ExpandTile({Key? key, required this.iconData, required this.title})
      : super(key: key);

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Icon(
              iconData,
              size: 32,
              color: Colors.grey[700],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }
}
