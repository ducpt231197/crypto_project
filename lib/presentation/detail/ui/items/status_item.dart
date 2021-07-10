import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  const StatusItem({Key? key, required this.title, required this.price}) : super(key: key);
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff070f71),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Text(
              '\$ $price',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Divider(
          height: 15,
          color: Colors.grey[300],
          thickness: 1,
        ),
      ],
    );
  }
}
