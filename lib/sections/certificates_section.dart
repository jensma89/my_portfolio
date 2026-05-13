// lib/sections/certificates_section.dart
// Certificates card — scrollable list with icon, title, and locale-aware download button.

import 'package:web/web.dart' as web;

import 'package:flutter/material.dart';
import '../components/portfolio_card.dart';
import '../components/buttons.dart';
import '../theme/theme.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    const certs = [
      _CertItem(
        titleEN: 'Backend Engineering Certificate',
        titleDE: 'Backend Engineering Zertifikat',
        issuer: 'MSIT (Masterschool Institute of Technology)',
        year: '2026',
        downloadUrlEN: 'assets/assets/certificates/jens_mayer_CoC_EN.pdf',
        downloadUrlDE: 'assets/assets/certificates/jens_mayer_CoC_DE.pdf',
      ),
    ];

    return PortfolioCard(
      semanticLabel: isDE ? 'Zertifikate' : 'Certificates',
      clipSize: 14,
      scrollable: true,
      maxHeight: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isDE ? 'Zertifikate' : 'Certificates',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 12),
          ...certs.map((c) => _CertTile(cert: c, isDE: isDE)),
        ],
      ),
    );
  }
}

class _CertItem {
  const _CertItem({
    required this.titleEN,
    required this.titleDE,
    required this.issuer,
    required this.year,
    required this.downloadUrlEN,
    required this.downloadUrlDE,
  });

  final String titleEN;
  final String titleDE;
  final String issuer;
  final String year;
  final String downloadUrlEN;
  final String downloadUrlDE;
}

class _CertTile extends StatelessWidget {
  const _CertTile({required this.cert, required this.isDE});

  final _CertItem cert;
  final bool isDE;

  @override
  Widget build(BuildContext context) {
    final title = isDE ? cert.titleDE : cert.titleEN;
    final downloadUrl = isDE ? cert.downloadUrlDE : cert.downloadUrlEN;

    return Semantics(
      label: '$title, ${cert.issuer}, ${cert.year}',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ExcludeSemantics(
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.accentBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.accentBlue,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cardTitle(context)),
                  const SizedBox(height: 2),
                  Text(
                    '${cert.issuer} · ${cert.year}',
                    style: AppTextStyles.small(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            DownloadButton(
              label: isDE ? 'Laden' : 'Download',
              onPressed: () {
                web.HTMLAnchorElement()
                  ..href = downloadUrl
                  ..setAttribute('download', '')
                  ..click();
              },
            ),
          ],
        ),
      ),
    );
  }
}
