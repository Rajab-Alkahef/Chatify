import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class contactCard extends StatelessWidget {
  const contactCard({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor:
              Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectesaffsdf",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
        const Text('3m ago'),
      ],
    );
  }
}
