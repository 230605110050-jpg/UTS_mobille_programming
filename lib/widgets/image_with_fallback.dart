import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageWithFallback extends StatefulWidget {
  final String? src;
  final String? alt;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ImageWithFallback({
    super.key,
    this.src,
    this.alt,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  State<ImageWithFallback> createState() => _ImageWithFallbackState();
}

class _ImageWithFallbackState extends State<ImageWithFallback> {
  bool didError = false;

  static const String _errorSvgBase64 =
      'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODgiIGhlaWdodD0iODgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgc3Ryb2tlPSIjMDAwIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBvcGFjaXR5PSIuMyIgZmlsbD0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIzLjciPjxyZWN0IHg9IjE2IiB5PSIxNiIgd2lkdGg9IjU2IiBoZWlnaHQ9IjU2IiByeD0iNiIvPjxwYXRoIGQ9Im0xNiA1OCAxNi0xOCAzMiAzMiIvPjxjaXJjbGUgY3g9IjUzIiBjeT0iMzUiIHI9IjciLz48L3N2Zz4KCg==';

  @override
  Widget build(BuildContext context) {
    if (didError || widget.src == null || widget.src!.isEmpty) {
      return _buildFallback();
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Image.network(
        widget.src!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorBuilder: (_, __, ___) => _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
      ),
      child: Center(
        child: Image.memory(
          _decodeBase64Image(_errorSvgBase64),
          width: widget.width != null ? widget.width! * 0.5 : 60,
          height: widget.height != null ? widget.height! * 0.5 : 60,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Helper to convert data:image/svg+xml;base64 string to Uint8List
  Uint8List _decodeBase64Image(String dataUri) {
    final base64String = dataUri.split(',').last;
    return base64.decode(base64String);
  }
}
