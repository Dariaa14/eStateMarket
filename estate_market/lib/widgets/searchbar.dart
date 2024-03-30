import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onSuffixTap;
  final String hintText;

  final bool? readOnly;
  final bool hasHighlight;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      this.prefix,
      this.suffix,
      this.onSuffixTap,
      this.onTap,
      this.onChanged,
      this.readOnly,
      required this.hintText,
      this.hasHighlight = false,
      this.controller,
      this.obscureText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _firstTime = true;
  String _prevInput = '';

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (_firstTime && widget.controller!.text.isNotEmpty) {
        _prevInput = widget.controller!.text;
        _firstTime = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: PlatformTextField(
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        hintText: widget.hintText,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,
        style: widget.hasHighlight
            ? Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant)
            : Theme.of(context).textTheme.headlineLarge!,
        material: (context, platform) => getMaterialSearchBarData(context, platform, widget.prefix, widget.suffix),
        cupertino: (context, platform) => getCupertinoSearchBarData(context, platform, widget.prefix, widget.suffix),
        onTap: widget.onTap,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        onChanged: (text) {
          if (widget.hasHighlight && widget.controller != null) {
            final newText = _prevInput.length > text.length ? '' : text[text.length - 1];

            widget.controller!.text = newText;
            widget.onChanged!(newText);
            _prevInput = newText;

            return;
          }

          if (widget.onChanged != null) {
            widget.onChanged!(text);
            _prevInput = text;
          }
        },
        cursorColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

CupertinoTextFieldData getCupertinoSearchBarData(
    BuildContext context, PlatformTarget target, Widget? prefix, Widget? suffix) {
  return CupertinoTextFieldData(
    prefix: prefix ??
        const SizedBox(
          width: 1.0,
        ),
    suffix: Padding(padding: const EdgeInsets.symmetric(horizontal: 3.0), child: suffix),
    style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
    placeholderStyle: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
    textAlignVertical: TextAlignVertical.center,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}

MaterialTextFieldData getMaterialSearchBarData(
    BuildContext context, PlatformTarget target, Widget? prefix, Widget? suffix) {
  return MaterialTextFieldData(
    textAlignVertical: TextAlignVertical.center,
    style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
    decoration: InputDecoration(
      prefixIcon: prefix ??
          const SizedBox(
            width: 1.0,
          ),
      suffixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 3.0), child: suffix),
      contentPadding: EdgeInsets.zero,
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
      fillColor: Theme.of(context).colorScheme.surfaceVariant,
    ),
  );
}
