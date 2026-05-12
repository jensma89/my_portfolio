// lib/sections/languages_section.dart
// Languages card — German (native), English (C1), Braille (basic) with progress bars.

import 'package:flutter/material.dart';
import '../components/portfolio_card.dart';
import '../theme/theme.dart';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    const items = [
      _LangItem(
        nameEN: 'German',
        nameDE: 'Deutsch',
        levelEN: 'Native',
        levelDE: 'Muttersprache',
        progress: 1.0,
      ),
      _LangItem(
        nameEN: 'English',
        nameDE: 'Englisch',
        levelEN: 'C1 – Advanced',
        levelDE: 'C1 – Fortgeschritten',
        progress: 0.85,
      ),
      _LangItem(
        nameEN: 'Braille',
        nameDE: 'Braille',
        levelEN: 'Basic',
        levelDE: 'Grundkenntnisse',
        progress: 0.2,
      ),
    ];

    return PortfolioCard(
      semanticLabel: isDE ? 'Sprachen' : 'Languages',
      clipSize: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isDE ? 'Sprachen' : 'Languages',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 14),
          ...items.map((item) => _LangBar(item: item, isDE: isDE)),
        ],
      ),
    );
  }
}

class _LangItem {
  const _LangItem({
    required this.nameEN,
    required this.nameDE,
    required this.levelEN,
    required this.levelDE,
    required this.progress,
  });

  final String nameEN;
  final String nameDE;
  final String levelEN;
  final String levelDE;
  final double progress;
}

class _LangBar extends StatelessWidget {
  const _LangBar({required this.item, required this.isDE});

  final _LangItem item;
  final bool isDE;

  @override
  Widget build(BuildContext context) {
    final name = isDE ? item.nameDE : item.nameEN;
    final level = isDE ? item.levelDE : item.levelEN;

    return Semantics(
      label: '$name: $level',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: AppTextStyles.cardTitle(context)),
                Text(level, style: AppTextStyles.small(context)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: item.progress,
                minHeight: 6,
                backgroundColor: AppColors.accentBlue.withValues(alpha: 0.15),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.accentBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
