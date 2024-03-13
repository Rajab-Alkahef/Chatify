import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.color = kPrimaryColor, required this.label, this.onTap});
  final Color color;
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            color: color,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
