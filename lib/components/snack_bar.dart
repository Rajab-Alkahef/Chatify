import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

void snackbar(BuildContext context, String message) {
  // String message;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Adjust the radius as needed
          topRight: Radius.circular(20), // Adjust the radius as needed
        ),
      ),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'OK',
        textColor: kSecondaryColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      content: Text(message),
      // showCloseIcon: true,
      // closeIconColor: kPrimaryColor,
    ),
  );
}
