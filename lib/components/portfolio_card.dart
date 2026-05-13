// lib/components/portfolio_card.dart
//
// Reusable card with:
//   - configurable diagonal corner clip via [clipSize]
//   - blue border, adaptive dark/light background
//   - optional scrollable content
//   - optional title
//   - screen reader accessible via Semantics

import 'package:flutter/material.dart';
import '../theme/theme.dart';

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    super.key,
    required this.child,
    this.title,
    this.semanticLabel,
    this.clipSize = 14.0,
    this.scrollable = false,
    this.padding = const EdgeInsets.all(20),
    this.maxHeight,
    this.constraints,
  });

  final Widget child;
  final String? title;
  final String? semanticLabel;

  /// Diagonal corner clip in logical pixels. 0 = normal rounded corners.
  final double clipSize;

  /// Wraps content in a SingleChildScrollView when true.
  final bool scrollable;

  final EdgeInsetsGeometry padding;
  final double? maxHeight;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content = Padding(
      padding: padding,
      child: scrollable
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [if (title != null) _buildTitle(context), child],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [if (title != null) _buildTitle(context), child],
            ),
    );

    if (maxHeight != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight!),
        child: content,
      );
    }

    if (constraints != null) {
      content = ConstrainedBox(constraints: constraints!, child: content);
    }

    return Semantics(
      label: semanticLabel ?? title,
      container: true,
      child: CustomPaint(
        painter: _ClippedBorderPainter(
          clipSize: clipSize,
          borderColor: colors.primary,
          fillColor: isDark ? AppColors.darkCard : AppColors.lightCard,
          shadowColor: isDark
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF2E2E2E),
        ),
        child: ClipPath(
          clipper: _DiagonalCornerClipper(clipSize: clipSize),
          child: content,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        title!,
        style: AppTextStyles.sectionHeading(context),
        semanticsLabel: title,
      ),
    );
  }
}

// Clips all four corners diagonally.
class _DiagonalCornerClipper extends CustomClipper<Path> {
  const _DiagonalCornerClipper({required this.clipSize});
  final double clipSize;

  @override
  Path getClip(Size size) {
    final c = clipSize;
    return Path()
      ..moveTo(c, 0)
      ..lineTo(size.width - c, 0)
      ..lineTo(size.width, c)
      ..lineTo(size.width, size.height - c)
      ..lineTo(size.width - c, size.height)
      ..lineTo(c, size.height)
      ..lineTo(0, size.height - c)
      ..lineTo(0, c)
      ..close();
  }

  @override
  bool shouldReclip(_DiagonalCornerClipper old) => old.clipSize != clipSize;
}

// Paints the fill color and clipped border.
class _ClippedBorderPainter extends CustomPainter {
  const _ClippedBorderPainter({
    required this.clipSize,
    required this.borderColor,
    required this.fillColor,
    required this.shadowColor,
  });

  final double clipSize;
  final Color borderColor;
  final Color fillColor;
  final Color shadowColor;

  Path _buildPath(Size size) {
    final c = clipSize;
    return Path()
      ..moveTo(c, 0)
      ..lineTo(size.width - c, 0)
      ..lineTo(size.width, c)
      ..lineTo(size.width, size.height - c)
      ..lineTo(size.width - c, size.height)
      ..lineTo(c, size.height)
      ..lineTo(0, size.height - c)
      ..lineTo(0, c)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // Subtle bottom-right elevation hint
    canvas.drawPath(
      path.shift(const Offset(4, 5)),
      Paint()
        ..color = shadowColor.withValues(alpha: 0.09)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(_ClippedBorderPainter old) =>
      old.clipSize != clipSize ||
      old.borderColor != borderColor ||
      old.fillColor != fillColor ||
      old.shadowColor != shadowColor;
}
