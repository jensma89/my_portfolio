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

    const projects = [
      _Project(
        titleEN: 'Revost - Lock and Load',
        titleDE: 'Revost - Lock and Load',
        descEN:
            'Real-time IoT infrastructure system connecting embedded devices, backend services and dashboards for a smart bike network across multiple stations.',
        descDE:
            'Echtzeit-IoT-Infrastruktursystem zur Verbindung von Embedded Devices, Backend-Services und Dashboards für ein Smart-Bike-Netzwerk über mehrere Stationen.',
        tags: [
          'Python',
          'Go',
          'FastAPI',
          'MQTT',
          'Arduino / ESP32',
        ],
        tagColors: [
          AppColors.badgePython,
          AppColors.badgeGo,
          AppColors.badgeFastAPI,
          AppColors.badgeMQTT,
          AppColors.badgeHardware,
        ],
        githubUrl: 'https://revost.nl/',
        hasTerminal: false,
      ),
      _Project(
        titleEN: 'Mythic Access DnD API (MVP)',
        titleDE: 'Mythic Access DnD API (MVP)',
        descEN:
            'Accessible backend API for tabletop RPG systems designed for visually impaired users, enabling structured and screen-reader friendly game data access and management.',
        descDE:
            'Barrierefreie Backend-API für ein Tabletop-RPG-System, entwickelt für sehbehinderte Nutzer mit strukturierter und screenreader-optimierter Datenzugriff-Architektur.',
        tags: [
          'Python',
          'FastAPI',
          'PostgreSQL / SQLAlchemy',
          'Docker',
          'JWT',
        ],
        tagColors: [
          AppColors.badgePython,
          AppColors.badgeFastAPI,
          AppColors.badgeDB,
          AppColors.badgeDocker,
          AppColors.badgeTest,
        ],
        githubUrl: 'https://github.com/jensma89/mythic-access-dnd',
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
          Semantics(
            header: true,
            child: Text(
              isDE ? 'Projekte' : 'Projects',
              style: AppTextStyles.sectionHeading(context),
            ),
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
    final isGitHub = project.githubUrl.contains('github.com');
    final linkIcon = isGitHub ? Icons.code_rounded : Icons.open_in_new_rounded;
    final linkLabel = isGitHub
        ? 'Open $title on GitHub'
        : (isDE ? '$title Website öffnen' : 'Open $title website');

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
                // GitHub / website icon button
                Semantics(
                  button: true,
                  link: true,
                  label: linkLabel,
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
                          linkIcon,
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
                                .withValues(alpha: 0.6),
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
            const Divider(
                height: 24,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Color(0x403A9BDC)),
          ],
        ),
      ),
    );
  }
}
