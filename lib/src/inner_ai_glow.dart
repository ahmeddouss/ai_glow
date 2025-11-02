import 'dart:math';
import 'package:flutter/material.dart';

/// A widget that paints an animated, colorful glow inside its [child].
///
/// Unlike [OuterAiGlow], which draws the glow outside the child's bounds,
/// [InnerAiGlowing] clips the content and paints the animated sweep gradient
/// on top of the child so the glow appears to emanate from within.
///
/// Example:
///
/// ```dart
/// InnerAiGlowing(
///   width: 140,
///   height: 140,
///   borderRadius: 20,
///   colors: [Colors.orange, Colors.red, Colors.deepPurple],
///   child: Image.asset('avatar.png'),
/// )
/// ```
class InnerAiGlowing extends StatefulWidget {
  /// The widget that will be displayed and receive the inner glow overlay.
  final Widget child;

  /// The height of the square that contains the child and the glow.
  ///
  /// Defaults to `100`.
  final double height;

  /// The width of the square that contains the child and the glow.
  ///
  /// Defaults to `100`.
  final double width;

  /// The corner radius applied when clipping the child and drawing the glow.
  ///
  /// Defaults to `10`.
  final double borderRadius;

  /// The stroke width of the glowing ring painted on top of the child.
  ///
  /// Defaults to `2`.
  final double glowWidth;

  /// The blur sigma applied to the glow. Larger values produce a softer glow.
  /// Defaults to `5`.
  final double blur;

  /// Colors used by the rotating sweep gradient.
  ///
  /// Defaults to `[Colors.blue, Colors.purple, Colors.pink]`.
  final List<Color> colors;

  /// Creates an [InnerAiGlowing].
  ///
  /// The [child] is required. Other parameters are optional and have
  /// defaults for quick usage.
  const InnerAiGlowing({
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
  State<InnerAiGlowing> createState() => _InnerAiGlowingState();
}

class _InnerAiGlowingState extends State<InnerAiGlowing> with SingleTickerProviderStateMixin {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.child,
            IgnorePointer(
              child: AnimatedBuilder(
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
                      child: const SizedBox.expand(),
                    ),
              ),
            ),
          ],
        ),
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
