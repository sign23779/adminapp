// import 'dart:core';

import 'package:flutter/material.dart';

class TextfieldContainer extends StatelessWidget {
  const TextfieldContainer(
      {Key? key,
      required this.controller,
      this.hinttext,
      this.trailingIcon,
      this.validator,
      this.initialValue,
      this.onTap,
      this.obscureText,
      this.errorText,
      this.keyboardType,
      this.leadingIcon,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final String? hinttext, errorText;
  final Icon? leadingIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final IconButton? trailingIcon;
  final void Function()? onTap;
  final bool? obscureText;

  // void OnChange;
  final void Function(String)? onChanged;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //300.sp,
      height: 55,
      decoration: BoxDecoration(
          color: const Color(0xffEEE9E9),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: onTap,
        leading: leadingIcon,
        title: TextFormField(
          obscureText: obscureText ?? false,
          onTap: onTap,
          initialValue: initialValue,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          controller: controller,
          decoration: InputDecoration(
            errorText: errorText,
            border: InputBorder.none,
            hintText: hinttext,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        trailing: trailingIcon,
      ),
    );
  }
}
