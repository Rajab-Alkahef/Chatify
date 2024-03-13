import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;
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
