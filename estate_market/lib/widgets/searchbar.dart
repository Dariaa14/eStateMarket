import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefix;

  final bool? readOnly;
  final bool hasHighlight;

  const MainSearchBar(
      {super.key, this.prefix, this.onTap, this.onChanged, this.readOnly, this.hasHighlight = false, this.controller});

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
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
        hintText: 'Search',
        textAlignVertical: TextAlignVertical.center,
        style: widget.hasHighlight
            ? Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant)
            : Theme.of(context).textTheme.headlineLarge!,
        material: (context, platform) => getMaterialSearchBarData(context, platform, widget.prefix),
        cupertino: (context, platform) => getCupertinoSearchBarData(context, platform, widget.prefix),
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

CupertinoTextFieldData getCupertinoSearchBarData(BuildContext context, PlatformTarget target, Widget? prefix) {
  return CupertinoTextFieldData(
    prefix: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: prefix ??
          Icon(
            CupertinoIcons.search,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    ),
    style: const TextStyle(fontSize: 20, color: Colors.grey),
    placeholderStyle: const TextStyle(fontSize: 20, color: Colors.grey),
    textAlignVertical: TextAlignVertical.center,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
  );
}

MaterialTextFieldData getMaterialSearchBarData(BuildContext context, PlatformTarget target, Widget? prefix) {
  return MaterialTextFieldData(
    textAlignVertical: TextAlignVertical.center,
    style: const TextStyle(fontSize: 20, color: Colors.grey),
    decoration: InputDecoration(
      prefixIcon: prefix ??
          Icon(
            CupertinoIcons.search,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      contentPadding: EdgeInsets.zero,
      hintText: 'Search',
      hintStyle: const TextStyle(fontSize: 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceVariant)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceVariant,
    ),
  );
}
