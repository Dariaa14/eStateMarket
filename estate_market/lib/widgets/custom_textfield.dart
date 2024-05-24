import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool showPrefix;

  final Widget? prefix;
  final Widget? suffix;

  final bool obscureText;

  const CustomTextfield(
      {super.key,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.onChanged,
      this.showPrefix = false,
      this.prefix,
      this.suffix,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PlatformTextField(
        obscureText: obscureText,
        controller: controller,
        hintText: hintText,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        material: (context, platform) =>
            getMaterialTextfieldData(context, platform, showPrefix, prefix: prefix, suffix: suffix),
        cupertino: (context, platform) =>
            getCupertinoTextfieldData(context, platform, showPrefix, prefix: prefix, suffix: suffix),
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        onChanged: onChanged,
      ),
    );
  }
}

CupertinoTextFieldData getCupertinoTextfieldData(BuildContext context, PlatformTarget target, bool showPrefix,
    {Widget? prefix, Widget? suffix}) {
  return CupertinoTextFieldData(
    style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
    placeholderStyle: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
    textAlignVertical: TextAlignVertical.center,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}

MaterialTextFieldData getMaterialTextfieldData(BuildContext context, PlatformTarget target, bool showPrefix,
    {Widget? prefix, Widget? suffix}) {
  return MaterialTextFieldData(
    textAlignVertical: TextAlignVertical.center,
    style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
    decoration: InputDecoration(
      errorText: showPrefix && prefix == null ? AppLocalizations.of(context)!.requiredField : null,
      prefixIcon: showPrefix
          ? prefix ??
              const Icon(
                Icons.not_interested,
                color: Colors.red,
              )
          : null,
      suffixIcon: suffix,
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
