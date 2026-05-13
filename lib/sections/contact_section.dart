// lib/sections/contact_section.dart
// Contact card — email (mailto, address not shown as plain text), GitHub, LinkedIn.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/portfolio_card.dart';
import '../components/buttons.dart';
import '../theme/theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.locale});

  final Locale locale;

  // Email is assembled at runtime so it is never stored as a plain-text
  // string literal that is trivially scraped.
  static String get _email {
    const parts = ['jensmayer', '89', '@', 'gmail', '.', 'com'];
    return parts.join();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri(scheme: 'mailto', path: _email);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    return PortfolioCard(
      semanticLabel: isDE ? 'Kontakt' : 'Contact',
      clipSize: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isDE ? 'Kontakt' : 'Contact',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 14),
          Builder(
            builder: (context) {
              final screenWidth = MediaQuery.of(context).size.width;
              final useColumn = screenWidth < 600;
              final buttons = [
                LinkButton(
                  label: isDE ? 'E-Mail senden' : 'Send Email',
                  icon: Icons.mail_outline_rounded,
                  semanticLabel: isDE ? 'E-Mail senden' : 'Send email',
                  onPressed: _sendEmail,
                ),
                LinkButton(
                  label: 'GitHub',
                  icon: Icons.code_rounded,
                  semanticLabel: 'Open GitHub profile',
                  onPressed: () => _openUrl('https://github.com/jensma89'),
                ),
                LinkButton(
                  label: 'LinkedIn',
                  icon: Icons.work_outline_rounded,
                  semanticLabel: 'Open LinkedIn profile',
                  onPressed: () =>
                      _openUrl('https://www.linkedin.com/in/jens-mayer-dev/'),
                ),
              ];
              if (useColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buttons[0],
                    const SizedBox(height: 10),
                    buttons[1],
                    const SizedBox(height: 10),
                    buttons[2],
                  ],
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buttons[0],
                  const SizedBox(width: 12),
                  buttons[1],
                  const SizedBox(width: 12),
                  buttons[2],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
