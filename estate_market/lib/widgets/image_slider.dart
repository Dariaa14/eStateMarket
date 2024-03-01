import 'dart:io';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<File> images;
  final Function(int)? onPageChanged;

  const ImageSlider({super.key, required this.images, this.onPageChanged});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              itemCount: widget.images.length,
              pageSnapping: true,
              onPageChanged: (int pageIndex) {
                setState(() {
                  currentIndex = pageIndex;
                });
                if (widget.onPageChanged != null) {
                  widget.onPageChanged!(pageIndex);
                }
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image.file(
                      widget.images[index],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              }),
        ),
        DotsIndicator(itemCount: widget.images.length, currentIndex: currentIndex),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotsIndicator({super.key, required this.itemCount, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, (index) {
          return Container(
            width: 10.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.surfaceVariant,
            ),
          );
        }),
      ),
    );
  }
}
