// lib/components/buttons.dart
//
// All reusable buttons for the portfolio.
//
// Accessibility:
//   - Every button exposes a semanticLabel for screen readers.
//   - Minimum tap target is 48x48 dp (WCAG 2.5.5).
//   - InkRipple splash provides touch feedback.
//   - Focus outline visible on keyboard navigation.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Primary accent button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    this.icon,
    this.isCompact = false,
  });

  final String label;
  final VoidCallback onPressed;
  final String? semanticLabel;
  final IconData? icon;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      label: semanticLabel ?? label,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon != null ? Icon(icon, size: 16) : const SizedBox.shrink(),
          label: Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w600,
              fontSize: isCompact ? 12 : 14,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12 : 20,
              vertical: isCompact ? 8 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            splashFactory: InkRipple.splashFactory,
          ),
        ),
      ),
    );
  }
}

// Icon-only toggle button used in the nav bar.
class IconToggleButton extends StatelessWidget {
  const IconToggleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.isActive = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String semanticLabel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          splashFactory: InkRipple.splashFactory,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 20,
              color: isActive ? color : color.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}

// Locale toggle chip (EN / DE).
class LocaleChip extends StatelessWidget {
  const LocaleChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Switch language to $label',
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isSelected ? color : color.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Outlined link button for contact / social links.
class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      link: true,
      label: semanticLabel ?? 'Open $label',
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 16, color: color),
          label: Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: color.withValues(alpha: 0.6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            splashFactory: InkRipple.splashFactory,
          ),
        ),
      ),
    );
  }
}

// Compact download button used in the certificates section.
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: label,
      onPressed: onPressed,
      semanticLabel: 'Download certificate: $label',
      icon: Icons.download_rounded,
      isCompact: true,
    );
  }
}
