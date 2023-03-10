import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.route})
      : super(key: key);

  final IconData iconData;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
        return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: SizedBox(
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
      ),
    );
  }
}
