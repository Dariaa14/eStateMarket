import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CreateAdTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CreateAdTextfield({super.key, this.controller, required this.hintText, this.keyboardType, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PlatformTextField(
        controller: controller,
        hintText: hintText,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        material: (context, platform) => getMaterialTextfieldData(context, platform),
        cupertino: (context, platform) => getCupertinoTextfieldData(context, platform),
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        onChanged: onChanged,
      ),
    );
  }
}

CupertinoTextFieldData getCupertinoTextfieldData(BuildContext context, PlatformTarget target) {
  return CupertinoTextFieldData(
    style: const TextStyle(fontSize: 15, color: Colors.grey),
    placeholderStyle: const TextStyle(fontSize: 15, color: Colors.grey),
    textAlignVertical: TextAlignVertical.center,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}

MaterialTextFieldData getMaterialTextfieldData(BuildContext context, PlatformTarget target) {
  return MaterialTextFieldData(
    textAlignVertical: TextAlignVertical.center,
    style: const TextStyle(fontSize: 15, color: Colors.grey),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(10.0),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
    ),
  );
}
