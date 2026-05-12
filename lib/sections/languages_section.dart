// lib/sections/languages_section.dart
// Languages card — circles with language abbreviation inside and level below.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        abbr: 'DE',
        nameEN: 'German',
        nameDE: 'Deutsch',
        levelEN: 'Native',
        levelDE: 'Muttersprache',
        progress: 1.0,
      ),
      _LangItem(
        abbr: 'EN',
        nameEN: 'English',
        nameDE: 'Englisch',
        levelEN: 'B2',
        levelDE: 'B2',
        progress: 0.7,
      ),
      _LangItem(
        abbr: 'BR',
        nameEN: 'Braille',
        nameDE: 'Braille',
        levelEN: 'Basic',
        levelDE: 'Grundkenntnisse',
        progress: 0.3,
      ),
    ];

    return PortfolioCard(
      semanticLabel: isDE ? 'Sprachen' : 'Languages',
      clipSize: 14,
      padding: const EdgeInsets.fromLTRB(23, 14, 23, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isDE ? 'Sprachen' : 'Languages',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => _LangCircle(item: item, isDE: isDE))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LangItem {
  const _LangItem({
    required this.abbr,
    required this.nameEN,
    required this.nameDE,
    required this.levelEN,
    required this.levelDE,
    required this.progress,
  });

  final String abbr;
  final String nameEN;
  final String nameDE;
  final String levelEN;
  final String levelDE;
  final double progress;
}

class _LangCircle extends StatelessWidget {
  const _LangCircle({required this.item, required this.isDE});

  final _LangItem item;
  final bool isDE;

  @override
  Widget build(BuildContext context) {
    final name = isDE ? item.nameDE : item.nameEN;
    final level = isDE ? item.levelDE : item.levelEN;

    return Semantics(
      label: '$name: $level',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: item.progress,
                  strokeWidth: 5,
                  backgroundColor: AppColors.accentBlue.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accentBlue,
                  ),
                ),
                Text(
                  isDE ? item.nameDE : item.nameEN,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 90,
            child: Text(
              level,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
