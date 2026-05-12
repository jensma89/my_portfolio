// lib/home_page.dart
// Responsive layout:
//   >= 900px → three-column (Skills+Certs | About+Languages | Projects)
//   <  900px → single-column stacked

import 'package:flutter/material.dart';
import 'sections/about_section.dart';
import 'sections/languages_section.dart';
import 'sections/skills_section.dart';
import 'sections/certificates_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

const double _kBreakpoint = 900.0;
const double _kGap = 16.0;

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _kBreakpoint) {
          return _WideLayout(locale: locale);
        }
        return _NarrowLayout(locale: locale);
      },
    );
  }
}

// --- Wide layout (>= 900 px) ---

class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column: Skills + Certificates
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SkillsSection(locale: locale),
                    const SizedBox(height: _kGap),
                    CertificatesSection(locale: locale),
                  ],
                ),
              ),
              const SizedBox(width: _kGap),
              // Center column: About + Languages
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AboutSection(locale: locale),
                    const SizedBox(height: _kGap),
                    LanguagesSection(locale: locale),
                  ],
                ),
              ),
              const SizedBox(width: _kGap),
              // Right column: Projects
              Expanded(
                child: ProjectsSection(locale: locale),
              ),
            ],
          ),
          const SizedBox(height: _kGap),
          ContactSection(locale: locale),
          FooterSection(locale: locale),
        ],
      ),
    );
  }
}

// --- Narrow layout (< 900 px) ---

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AboutSection(locale: locale),
          const SizedBox(height: _kGap),
          LanguagesSection(locale: locale),
          const SizedBox(height: _kGap),
          SkillsSection(locale: locale),
          const SizedBox(height: _kGap),
          CertificatesSection(locale: locale),
          const SizedBox(height: _kGap),
          ProjectsSection(locale: locale),
          const SizedBox(height: _kGap),
          ContactSection(locale: locale),
          FooterSection(locale: locale),
        ],
      ),
    );
  }
}
