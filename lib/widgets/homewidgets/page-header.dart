import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var notificationBox = Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: const BorderRadius.all(Radius.circular(6.67)),
      ),
      child: const Icon(
        CupertinoIcons.bell,
        color: Colors.white,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text('Huzefa Abbasi',
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 23)),
          ],
        ),
        notificationBox
      ],
    );
  }
}
