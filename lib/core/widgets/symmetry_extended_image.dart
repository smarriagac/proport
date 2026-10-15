import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Highly optimized image projector leveraging ExtendedImage for local assets
/// and remote CDN assets with memory/disk caching, smooth animations, and fallbacks.
class SymmetryExtendedImage extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool clearMemoryCacheWhenDispose;

  const SymmetryExtendedImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.placeholder,
    this.errorWidget,
    this.clearMemoryCacheWhenDispose = false,
  });

  bool get _isNetwork =>
      source.startsWith('http://') || source.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (_isNetwork) {
      image = ExtendedImage.network(
        source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        cache: true,
        gaplessPlayback: true,
        clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return placeholder ?? _defaultLoading();
            case LoadState.completed:
              return null; // renders image natively
            case LoadState.failed:
              return errorWidget ?? _defaultError();
          }
        },
      );
    } else {
      image = ExtendedImage.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        gaplessPlayback: true,
        clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return placeholder ?? _defaultLoading();
            case LoadState.completed:
              return null;
            case LoadState.failed:
              return errorWidget ?? _defaultError();
          }
        },
      );
    }

    if (shape == BoxShape.circle) {
      return ClipOval(child: image);
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _defaultLoading() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFF141416),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryBlue,
          ),
        ),
      ),
    );
  }

  Widget _defaultError() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFF141416),
      child: const Center(
        child: Icon(
          Icons.fitness_center_rounded,
          color: Colors.white38,
          size: 24,
        ),
      ),
    );
  }
}
