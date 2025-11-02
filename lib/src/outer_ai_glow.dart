import 'dart:math';
import 'package:flutter/material.dart';

/// A widget that paints an animated, colorful glow around its [child].
///
/// The glow is rendered outside the child's bounds using a rotating
/// sweep gradient. Customize the visual appearance with [colors],
/// [glowWidth], [blur], [borderRadius] and the overall [width]/[height].
///
/// Example:
///
/// ```dart
/// OuterAiGlow(
///   width: 120,
///   height: 120,
///   borderRadius: 16,
///   colors: [Colors.cyan, Colors.indigo, Colors.pink],
///   child: Icon(Icons.star, size: 48),
/// )
/// ```
class OuterAiGlow extends StatefulWidget {
  /// The widget that will appear centered inside the glowing area.
  final Widget child;

  /// The height of the square that contains the child and the glow.
  ///
  /// Defaults to `100`.
  final double height;

  /// The width of the square that contains the child and the glow.
  ///
  /// Defaults to `100`.
  final double width;

  /// The corner radius applied to the rounded rectangle used for the glow.
  ///
  /// Defaults to `10`.
  final double borderRadius;

  /// The stroke width of the glowing ring.
  ///
  /// Larger values create a thicker glow. Defaults to `2`.
  final double glowWidth;

  /// The blur sigma applied to the glow's mask filter. Higher values make
  /// the glow softer. Defaults to `5`.
  final double blur;

  /// Colors used for the rotating sweep gradient. The gradient will cycle
  /// through the provided colors; the first color is appended to the end to
  /// create a smooth rotation loop.
  ///
  /// Defaults to `[Colors.blue, Colors.purple, Colors.pink]`.
  final List<Color> colors;

  /// Creates an [OuterAiGlow].
  ///
  /// The [child] parameter is required. All other parameters are optional
  /// and have sensible defaults for immediate use.
  const OuterAiGlow({
    super.key,
    required this.child,
    this.height = 100,
    this.width = 100,
    this.borderRadius = 10,
    this.glowWidth = 2,
    this.blur = 5,
    this.colors = const [Colors.blue, Colors.purple, Colors.pink],
  });

  @override
  State<OuterAiGlow> createState() => _OuterAiGlowState();
}

class _OuterAiGlowState extends State<OuterAiGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder:
                (_, __) => CustomPaint(
                  painter: _GlowPainter(
                    animationValue: _controller.value,
                    colors: widget.colors,
                    borderRadius: widget.borderRadius,
                    glowWidth: widget.glowWidth,
                    blur: widget.blur,
                  ),
                  child: const SizedBox.expand(), // Ensures the glow fills the space
                ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;
  final double borderRadius;
  final double glowWidth;
  final double blur;

  _GlowPainter({
    required this.animationValue,
    required this.colors,
    required this.borderRadius,
    required this.glowWidth,
    required this.blur,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final RRect roundedRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final stops = List.generate(colors.length + 1, (i) => i / (colors.length));

    final sweepGradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: [...colors, colors.first],
      stops: stops,
      transform: GradientRotation(2 * pi * animationValue),
    );

    final Paint glowStrokePaint =
        Paint()
          ..shader = sweepGradient.createShader(rect.inflate(glowWidth))
          ..style = PaintingStyle.stroke
          ..strokeWidth = glowWidth
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    canvas.drawRRect(roundedRect.deflate(1.0), glowStrokePaint);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        colors != oldDelegate.colors ||
        borderRadius != oldDelegate.borderRadius;
  }
}
