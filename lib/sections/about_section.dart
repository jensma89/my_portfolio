// lib/sections/about_section.dart
// About me card — profile picture, name, bio, hobby chips.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/portfolio_card.dart';
import '../theme/theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    final hobbies = isDE
        ? ['Programmieren', 'IoT', 'Elektronik', 'Musik', 'Wandern']
        : ['Coding', 'IoT', 'Electronics', 'Music', 'Hiking'];

    final bio = isDE
        ? 'Backend- & IoT-Entwickler mit Leidenschaft für sauberen Code, verteilte Systeme und eingebettete Hardware.'
        : 'Backend & IoT developer passionate about clean code, distributed systems, and embedded hardware.';

    return PortfolioCard(
      semanticLabel: isDE ? 'Über mich' : 'About me',
      clipSize: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Profile picture of Jens Mayer',
                image: true,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1F000000),
                        blurRadius: 20,
                        offset: Offset(12, 0),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/profile_picture_no_background.png',
                    height: 208,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 26),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jens Mayer', style: AppTextStyles.name(context)),
                    const SizedBox(height: 6),
                    Text(bio, style: AppTextStyles.body(context)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: hobbies
                .map(
                  (h) => Chip(
                    label: Text(
                      h,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.accentBlue,
                      ),
                    ),
                    backgroundColor: AppColors.accentBlue.withValues(alpha: 0.1),
                    side: BorderSide(color: AppColors.accentBlue.withValues(alpha: 0.3)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
