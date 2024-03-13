import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField({
    super.key,
    this.onChanged,
    required this.hintText,
  });
  final String hintText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding / 3,
        ),
        child: TextField(
          onChanged: onChanged,
          autofillHints: const [AutofillHints.email],
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)
                      .color,
                  // ?.withOpacity(0.64),
                ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
