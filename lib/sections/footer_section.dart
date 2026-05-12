// lib/sections/footer_section.dart
// Footer — Imprint / Privacy Policy / Legal links + copyright.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.locale});

  final Locale locale;

  void _showDialog(BuildContext context, String title, String body) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: AppTextStyles.cardTitle(context)),
        content: Text(body, style: AppTextStyles.body(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              locale.languageCode == 'de' ? 'Schließen' : 'Close',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    final linkStyle = GoogleFonts.inter(
      fontSize: 12,
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
      decorationColor: Theme.of(context).colorScheme.primary,
    );

    final dimStyle = GoogleFonts.inter(
      fontSize: 12,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
    );

    Widget footerLink({
      required String label,
      required String dialogTitle,
      required String dialogBody,
    }) {
      return Semantics(
        button: true,
        link: true,
        label: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _showDialog(context, dialogTitle, dialogBody),
            child: Text(label, style: linkStyle),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        children: [
          Divider(color: AppColors.accentBlue.withOpacity(0.2)),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 6,
            children: [
              footerLink(
                label: isDE ? 'Impressum' : 'Imprint',
                dialogTitle: isDE ? 'Impressum' : 'Imprint',
                dialogBody: isDE
                    ? 'Jens Mayer\nAngaben gemäß § 5 TMG.'
                    : 'Jens Mayer\nInformation in accordance with § 5 TMG.',
              ),
              footerLink(
                label: isDE ? 'Datenschutz' : 'Privacy Policy',
                dialogTitle: isDE ? 'Datenschutzerklärung' : 'Privacy Policy',
                dialogBody: isDE
                    ? 'Diese Website erhebt keine personenbezogenen Daten.'
                    : 'This website does not collect any personal data.',
              ),
              footerLink(
                label: isDE ? 'Rechtliches' : 'Legal',
                dialogTitle: isDE ? 'Rechtliche Hinweise' : 'Legal Notice',
                dialogBody: isDE
                    ? 'Alle Inhalte dieser Website sind urheberrechtlich geschützt.'
                    : 'All content on this website is protected by copyright.',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('© 2026 Jens Mayer', style: dimStyle),
        ],
      ),
    );
  }
}
