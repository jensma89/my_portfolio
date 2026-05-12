// lib/components/nav_bar.dart
// Top nav bar — EN/DE locale toggle + Dark/Light theme toggle.

import 'package:flutter/material.dart';
import 'buttons.dart';

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
            const SizedBox(width: 12),
            LocaleChip(
              label: 'Dark',
              isSelected: isDarkMode,
              onTap: isDarkMode ? () {} : onThemeToggle,
            ),
            const SizedBox(width: 4),
            LocaleChip(
              label: 'Light',
              isSelected: !isDarkMode,
              onTap: isDarkMode ? onThemeToggle : () {},
            ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
