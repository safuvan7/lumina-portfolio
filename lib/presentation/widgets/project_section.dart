import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lumina/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lumina/presentation/widgets/hover_card.dart';

class ProjectSection extends StatelessWidget {
  ProjectSection({super.key});

  final projects = [
    ProjectModel(
      title: 'Travel Budget Planner',
      category: 'Flutter Mobile Application',
      description:
          'A complete travel planning application that helps users manage '
          'trips, track expenses, organize checklists, add notes, and '
          'analyze travel budgets.',
      imagePath: 'assets/images/travel_budget_planner.png',
      technologies: ['Flutter', 'Dart', 'Firebase', 'BLoC'],
      githubUrl: 'https://github.com/safuvan7',
      demoUrl: 'YOUR_LIVE_DEMO_LINK',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _ProjectsHeader(),

              SizedBox(height: 60),

              _ProjectGrid(projects: projects),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION HEADER
// ============================================================
class _ProjectsHeader extends StatelessWidget {
  const _ProjectsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final titleSize = isMobile ? 32.0 : 42.0;
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Featured ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'Projects',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 18),

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 650),
          child: Text(
            'A selection of projects that demonstrate my skills in Flutter '
            'development and building modern mobile applications.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// RESPONSIVE PROJECTS GRID
// ============================================================
class _ProjectGrid extends StatelessWidget {
  const _ProjectGrid({
    super.key,
    required this.projects,
  });

  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final crossAxisCount = width >= 1000
            ? 3
            : width >= 650
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,

            // More space for project content
            mainAxisExtent: width >= 650 ? 560 : 540,
          ),
          itemBuilder: (context, index) {
            return ProjectCard(
              project: projects[index],
            );
          },
        );
      },
    );
  }
}

// ============================================================
// PROJECT CARD
// ============================================================
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.tryParse(url);

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasGithub = project.githubUrl.isNotEmpty;
    final hasDemo = project.demoUrl.isNotEmpty;

    return HoverCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.surfaceBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= PROJECT IMAGE =================
                SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: Image.asset(
                    project.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: AppColors.primary,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Project Image',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ================= PROJECT DETAILS =================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.category.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          project.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          project.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Technologies
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.technologies
                              .map(
                                (technology) => _TechnologyChip(
                              title: technology,
                            ),
                          )
                              .toList(),
                        ),

                        const Spacer(),

                        // Project Links
                        Row(
                          children: [
                            _ProjectButton(
                              icon: Icons.code_rounded,
                              title: 'GitHub',
                              isEnabled: hasGithub,
                              onTap: hasGithub
                                  ? () => _openUrl(project.githubUrl)
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            _ProjectButton(
                              icon: Icons.open_in_new_rounded,
                              title: 'Demo',
                              isEnabled: hasDemo,
                              onTap: hasDemo
                                  ? () => _openUrl(project.demoUrl)
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROJECT BUTTON
// ============================================================

class _ProjectButton extends StatelessWidget {
  const _ProjectButton({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isEnabled,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 17,
        ),
        label: Text(title),
        style: OutlinedButton.styleFrom(
          foregroundColor: isEnabled
              ? AppColors.textPrimary
              : AppColors.textSecondary.withValues(alpha: 0.5),
          side: BorderSide(
            color: isEnabled
                ? AppColors.surfaceBorder
                : AppColors.surfaceBorder.withValues(alpha: 0.4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }
}

// ============================================================
// TECHNOLOGY CHIP
// ============================================================
class _TechnologyChip extends StatelessWidget {
  const _TechnologyChip({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ============================================================
// PROJECT MODEL
// ============================================================

class ProjectModel {
  final String title;
  final String category;
  final String description;
  final String imagePath;
  final List<String> technologies;
  final String githubUrl;
  final String demoUrl;

  const ProjectModel({
    required this.title,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.technologies,
    required this.githubUrl,
    required this.demoUrl,
  });
}
