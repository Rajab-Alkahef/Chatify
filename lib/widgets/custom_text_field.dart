import 'package:chat_app_new/constants.dart';
import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  const customTextField({
    super.key,
    this.onChanged,
    required this.hintText,
  });
  final String hintText;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2.5,
      ),
      child: TextFormField(
        style: const TextStyle(height: 0.8),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
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
    );
  }
}
