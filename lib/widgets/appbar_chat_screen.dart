import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

AppBar AppBarChatScreen(BuildContext context) {
  return AppBar(
    title: const Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/photo.png",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              // vertical: kDefaultPadding*2,
              horizontal: kDefaultPadding * 0.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Rajab Alkahef', style: TextStyle(fontSize: 16)),
              Text(
                'Active 3m ago',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.local_phone),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.local_phone),
      ),
    ],
    shadowColor: Colors.black,
    // elevation: 200,
    backgroundColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? kPrimaryColor
            : const Color(0xff272244),
  );
}
