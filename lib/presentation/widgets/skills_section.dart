import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lumina/constants/colors.dart';
import 'package:lumina/presentation/widgets/hover_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
              _SectionHeader(
                firstTitle: 'Skills &',
                secondTitle: ' Expertise',
                description:
                    'My technical toolkit for building robust mobile applications.',
              ),
              SizedBox(height: 60),

              //   Responsive Skills Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  int crossAxisCount;
                  double cardHeight;
                  if (width >= 1100) {
                    crossAxisCount = 4;
                    cardHeight = 400;
                  } else if (width >= 700) {
                    crossAxisCount = 2;
                    cardHeight = 320;
                  } else {
                    crossAxisCount = 1;
                    cardHeight = 280;
                  }

                  return GridView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1.8,
                      mainAxisExtent: cardHeight
                    ),
                    itemBuilder: (context, index) {
                      final cards = [
                        SkillCard(
                          icon: Icons.code_rounded,
                          title: 'Programming',
                          skills: [
                            'Dart',
                            'Java',
                            'JavaScript',
                            'HTML',
                            'CSS',
                          ],
                        ),
                        SkillCard(
                          icon: Icons.phone_android_rounded,
                          title: 'Mobile Development',
                          skills: [
                            'Flutter',
                            'Android',
                            'Responsive UI',
                            'REST API',
                          ],
                        ),
                        SkillCard(
                          icon: Icons.storage_rounded,
                          title: 'Backend & Database',
                          skills: [
                            'Firebase',
                            'Firestore',
                            'MongoDB',
                            'SQLite',
                            'Node.js',
                          ],
                        ),
                        SkillCard(
                          icon: Icons.settings_suggest_rounded,
                          title: 'State Management & Tools',
                          skills: [
                            'BLoC',
                            'Provider',
                            'Riverpod',
                            'Git',
                            'GitHub',
                          ],
                        ),
                      ];

                      return cards[index];
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.description,
  });

  final String firstTitle;
  final String secondTitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = width < 600 ? 32.0 : 42.0;
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: firstTitle,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: secondTitle,
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
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
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

class SkillCard extends StatelessWidget {
  const SkillCard({
    super.key,
    required this.icon,
    required this.title,
    required this.skills,
  });

  final IconData icon;
  final String title;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            padding: const EdgeInsets.all(28),
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
                // Icon
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 20),

                // Skills Chips
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: skills.map((skill) {
                    return _SkillChip(title: skill);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
