import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateAdTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool showPrefix;

  const CreateAdTextfield(
      {super.key, this.controller, this.hintText, this.keyboardType, this.onChanged, this.showPrefix = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PlatformTextField(
        controller: controller,
        hintText: hintText,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        material: (context, platform) => getMaterialTextfieldData(context, platform, showPrefix),
        cupertino: (context, platform) => getCupertinoTextfieldData(context, platform, showPrefix),
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        onChanged: onChanged,
      ),
    );
  }
}

CupertinoTextFieldData getCupertinoTextfieldData(BuildContext context, PlatformTarget target, bool showPrefix) {
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

MaterialTextFieldData getMaterialTextfieldData(BuildContext context, PlatformTarget target, bool showPrefix) {
  return MaterialTextFieldData(
    textAlignVertical: TextAlignVertical.center,
    style: const TextStyle(fontSize: 15, color: Colors.grey),
    decoration: InputDecoration(
      errorText: showPrefix ? AppLocalizations.of(context)!.requiredField : null,
      prefixIcon: showPrefix
          ? const Icon(
              Icons.not_interested,
              color: Colors.red,
            )
          : null,
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
