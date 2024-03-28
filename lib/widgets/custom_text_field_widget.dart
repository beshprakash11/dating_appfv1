import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool? isObscure;
  const CustomTextFieldWidget({
    Key? key,
    required this.editingController,
    this.iconData,
    this.assetRef,
    this.labelText,
    this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
