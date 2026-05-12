// lib/components/nav_bar.dart
// Top nav bar — EN/DE locale toggle + dark/light theme toggle.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'buttons.dart';
import '../theme/theme.dart';

class PortfolioNavBar extends StatelessWidget implements PreferredSizeWidget {
  const PortfolioNavBar({
    super.key,
    required this.isDarkMode,
    required this.locale,
    required this.onThemeToggle,
    required this.onLocaleToggle,
  });

  final bool isDarkMode;
  final Locale locale;
  final VoidCallback onThemeToggle;
  final VoidCallback onLocaleToggle;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    return AppBar(
      automaticallyImplyLeading: false,
      title: Semantics(
        header: true,
        label: 'Jens Mayer Portfolio',
        child: Text(
          'Jens Mayer',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LocaleChip(
              label: 'EN',
              isSelected: !isDE,
              onTap: isDE ? onLocaleToggle : () {},
            ),
            const SizedBox(width: 4),
            LocaleChip(
              label: 'DE',
              isSelected: isDE,
              onTap: isDE ? () {} : onLocaleToggle,
            ),
            const SizedBox(width: 6),
            IconToggleButton(
              icon: isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              onPressed: onThemeToggle,
              semanticLabel:
                  isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
              isActive: true,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
