// lib/sections/projects_section.dart
// Projects card — scrollable list with title, description, tech tags,
// GitHub icon, and optional play button (shows SnackBar "Terminal coming soon!").

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/portfolio_card.dart';
import '../components/skill_badge.dart';
import '../theme/theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final isDE = locale.languageCode == 'de';

    final projects = [
      _Project(
        titleEN: 'Home Automation Hub',
        titleDE: 'Heimautomatisierungs-Hub',
        descEN:
            'Self-hosted MQTT broker and web dashboard for managing IoT devices across a Raspberry Pi cluster.',
        descDE:
            'Selbst gehosteter MQTT-Broker mit Web-Dashboard zur Verwaltung von IoT-Geräten auf einem Raspberry-Pi-Cluster.',
        tags: const ['Python', 'MQTT', 'Raspberry Pi', 'Linux'],
        tagColors: const [
          AppColors.badgePython,
          AppColors.badgeMQTT,
          AppColors.badgeRaspberryPi,
          AppColors.badgeLinux,
        ],
        githubUrl: 'https://github.com/jens-mayer',
        hasTerminal: true,
      ),
      _Project(
        titleEN: 'FastAPI Boilerplate',
        titleDE: 'FastAPI Boilerplate',
        descEN:
            'Production-ready project template with Docker Compose, async SQLAlchemy, JWT auth, and CI/CD pipelines.',
        descDE:
            'Produktionsfertiges Projekttemplate mit Docker Compose, async SQLAlchemy, JWT-Auth und CI/CD-Pipelines.',
        tags: const ['FastAPI', 'Docker', 'Python'],
        tagColors: const [
          AppColors.badgeFastAPI,
          AppColors.badgeDocker,
          AppColors.badgePython,
        ],
        githubUrl: 'https://github.com/jens-mayer',
        hasTerminal: false,
      ),
      _Project(
        titleEN: 'Go Microservice Toolkit',
        titleDE: 'Go-Microservice-Toolkit',
        descEN:
            'Lightweight toolkit for Go microservices with structured logging, health checks, and graceful shutdown.',
        descDE:
            'Leichtgewichtiges Toolkit für Go-Microservices mit strukturiertem Logging, Health-Checks und Graceful Shutdown.',
        tags: const ['Go', 'Docker', 'Linux'],
        tagColors: const [
          AppColors.badgeGo,
          AppColors.badgeDocker,
          AppColors.badgeLinux,
        ],
        githubUrl: 'https://github.com/jens-mayer',
        hasTerminal: false,
      ),
    ];

    return PortfolioCard(
      semanticLabel: isDE ? 'Projekte' : 'Projects',
      clipSize: 14,
      scrollable: true,
      maxHeight: 520,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isDE ? 'Projekte' : 'Projects',
            style: AppTextStyles.sectionHeading(context),
          ),
          const SizedBox(height: 12),
          ...projects.map((p) => _ProjectTile(project: p, isDE: isDE)),
        ],
      ),
    );
  }
}

class _Project {
  const _Project({
    required this.titleEN,
    required this.titleDE,
    required this.descEN,
    required this.descDE,
    required this.tags,
    required this.tagColors,
    required this.githubUrl,
    required this.hasTerminal,
  });

  final String titleEN;
  final String titleDE;
  final String descEN;
  final String descDE;
  final List<String> tags;
  final List<Color> tagColors;
  final String githubUrl;
  final bool hasTerminal;
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({required this.project, required this.isDE});

  final _Project project;
  final bool isDE;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = isDE ? project.titleDE : project.titleEN;
    final desc = isDE ? project.descDE : project.descEN;
    final terminalLabel =
        isDE ? 'Terminal öffnen für $title' : 'Open terminal for $title';
    final githubLabel = 'Open $title on GitHub';

    return Semantics(
      label: title,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(title, style: AppTextStyles.cardTitle(context)),
                ),
                // GitHub icon button
                Semantics(
                  button: true,
                  link: true,
                  label: githubLabel,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 48, minHeight: 48),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _openUrl(project.githubUrl),
                      splashFactory: InkRipple.splashFactory,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.code_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                // Optional terminal play button
                if (project.hasTerminal)
                  Semantics(
                    button: true,
                    label: terminalLabel,
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minWidth: 48, minHeight: 48),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isDE
                                    ? 'Terminal demnächst verfügbar!'
                                    : 'Terminal coming soon!',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        splashFactory: InkRipple.splashFactory,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.terminal_rounded,
                            size: 18,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(desc, style: AppTextStyles.body(context)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (int i = 0; i < project.tags.length; i++)
                  SkillBadge(
                    label: project.tags[i],
                    color: project.tagColors[i],
                  ),
              ],
            ),
            const Divider(height: 24),
          ],
        ),
      ),
    );
  }
}
