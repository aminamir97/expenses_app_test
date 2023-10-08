import 'package:expenses_app/app/theme/colors.dart';
import 'package:expenses_app/app/theme/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      this.obscure = false,
      this.validator,
      this.onSaved,
      this.initialValue,
      this.textInputType,
      this.textCapitalization = TextCapitalization.none,
      this.icon});

  final String hint;
  final Icon? icon;

  final bool obscure;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final String? initialValue;
  final String? Function(String? x)? validator;
  final void Function(String? x)? onSaved;

  @override
  Widget build(BuildContext context) {
    bool hideText = obscure;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          initialValue: initialValue,
          obscureText: hideText,
          style: AppFonts.subtitle1.copyWith(color: Colors.black),
          keyboardType: textInputType,
          textCapitalization: textCapitalization,
          validator: validator,
          onSaved: onSaved,
          autovalidateMode: AutovalidateMode.disabled,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icon == null
                ? null
                : IconButton(
                    splashRadius: 20,
                    color: AppColors.grey700,
                    onPressed: () => setState(() => hideText = !hideText),
                    icon: icon!),
          ),
        );
      },
    );
  }
}
