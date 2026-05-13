// lib/sections/skills_section.dart
// Skills card — Backend Development + IoT Development with colored pill badges.

import 'package:flutter/material.dart';
import '../components/portfolio_card.dart';
import '../components/skill_badge.dart';
import '../theme/theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    return PortfolioCard(
      semanticLabel: isDE ? 'Fähigkeiten' : 'Skills',
      clipSize: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isDE ? 'Fähigkeiten' : 'Skills',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 14),
          Text(
            isDE ? 'Backend-Systeme' : 'Backend Systems',
            style: AppTextStyles.cardTitle(context),
          ),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SkillBadge(label: 'Python', color: AppColors.badgePython),
              SkillBadge(label: 'Go', color: AppColors.badgeGo),
              SkillBadge(label: 'FastAPI', color: AppColors.badgeFastAPI),
              SkillBadge(label: 'REST APIs', color: AppColors.badgeAPI),
              SkillBadge(label: 'Docker', color: AppColors.badgeDocker),
              SkillBadge(label: 'PostgreSQL', color: AppColors.badgeDB),
              SkillBadge(label: 'SQLAlchemy (ORM)', color: AppColors.badgeORM),
              SkillBadge(label: 'Git', color: AppColors.badgeGit),
              SkillBadge(label: 'Unit Testing', color: AppColors.badgeTest),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isDE ? 'IoT & Embedded Systeme' : 'IoT & Embedded Systems',
            style: AppTextStyles.cardTitle(context),
          ),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SkillBadge(label: 'MQTT', color: AppColors.badgeMQTT),
              SkillBadge(
                  label: 'Arduino / ESP32', color: AppColors.badgeHardware),
              SkillBadge(label: 'Linux', color: AppColors.badgeLinux),
              SkillBadge(label: 'BLE Communication', color: AppColors.badgeBLE),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isDE ? 'Barrierefreiheit' : 'Accessibility',
            style: AppTextStyles.cardTitle(context),
          ),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SkillBadge(label: 'Screen Reader Awareness', color: AppColors.badgeA11y),
              SkillBadge(label: 'Braille Navigation Experience', color: AppColors.badgeA11y),
              SkillBadge(label: 'Flutter Accessibility Basics', color: AppColors.badgeA11y),
            ],
          ),
        ],
      ),
    );
  }
}
