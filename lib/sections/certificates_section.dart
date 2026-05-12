// lib/sections/certificates_section.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/portfolio_card.dart';
import '../components/buttons.dart';
import '../theme/theme.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    final certs = [
      _CertItem(
        titleEN: 'Python Advanced Developer',
        titleDE: 'Python für Fortgeschrittene',
        issuer: 'Coursera',
        year: '2024',
        downloadUrlEN: 'assets/certificates/cert_python_en.pdf',
        downloadUrlDE: 'assets/certificates/cert_python_de.pdf',
      ),
      _CertItem(
        titleEN: 'Docker & Containers',
        titleDE: 'Docker & Container-Technologien',
        issuer: 'Udemy',
        year: '2023',
        downloadUrlEN: 'assets/certificates/cert_docker_en.pdf',
        downloadUrlDE: 'assets/certificates/cert_docker_de.pdf',
      ),
    ];

    return PortfolioCard(
      semanticLabel: isDE ? 'Zertifikate' : 'Certificates',
      clipSize: 14,
      scrollable: true,
      maxHeight: 360,
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
            Semantics(
              label: 'Certificate image',
              image: true,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.accentBlue.withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.accentBlue,
                  size: 28,
                ),
                // TODO: replace with real image:
                // child: Image.asset('assets/certificates/cert_preview.png', fit: BoxFit.cover),
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
              onPressed: () async {
                final uri = Uri.parse(downloadUrl);
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
            ),
          ],
        ),
      ),
    );
  }
}
