import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lumina/constants/colors.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 700;
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              _ExperienceHeader(),

              SizedBox(height: 60),
              // Experience Time Line
              _ExperienceTimeline(isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }
}

//==========================================
// SECTION HEADER
//=========================================

class _ExperienceHeader extends StatelessWidget {
  const _ExperienceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final titleSize = isMobile ? 32.0 : 42.0;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Professional ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'Experience',
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

        Text(
          'My journey of learning, building, and gaining hands-on '
          'experience in software development.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 17,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ===================================
// EXPERIENCE TIMELINE
// ===================================

class _ExperienceTimeline extends StatelessWidget {
  _ExperienceTimeline({super.key, required this.isMobile});

  final bool isMobile;

  final experience = [
    ExperienceModel(
      role: 'Android Flutter App Development Intern',
      company: 'Luminar Technolab | Calicut, Kerala',
      duration: 'Sept 2024 - March 2025',
      description:
          'Built Flutter application features and user interfaces while '
          'learning real-world software development practices and '
          'collaborating on mobile projects.',
      skills: ['Flutter', 'Firebase', 'REST APIs', 'SQLite'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experience.length, (index) {
        final isLast = index == experience.length - 1;
        return _TimelineItem(
          experience: experience[index],
          isLast: isLast,
          isMobile: isMobile,
        );
      }),
    );
  }
}

// ============================================================
// TIMELINE ITEM
// ============================================================

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    super.key,
    required this.experience,
    required this.isLast,
    required this.isMobile,
  });

  final ExperienceModel experience;
  final bool isLast;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        //   Timeline indicator
          SizedBox(
            width: isMobile ? 40 : 70,
            child: Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle
                  ),
                ),
                
                if(!isLast)
                  Expanded(
                      child: Container(
                        width: 2,
                        color: AppColors.primary.withValues(alpha: 0.35),
                      ) 
                  )
              ],
            ),
          ),
          
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : 30
                  ),
                child: ExperienceCard(
                  experience: experience,
                ),
              ) 
          )
        ],
      ),
    );
  }
}

// ============================================================
// GLASS EXPERIENCE CARD
// ============================================================
class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.experience});

  final ExperienceModel experience;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.surfaceBorder
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //   Duration
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  experience.duration,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 20,),

            //   Role
              Text(
                experience.role,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8,),

            //   company
              Row(
                children: [
                  Icon(
                    Icons.business_outlined,
                    color: AppColors.secondary,
                    size: 19,
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                      child: Text(
                        experience.company,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16
                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 16,),

            //   Description
              Text(
                experience.description,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.6
                ),
              ),
              SizedBox(height: 22,),

            //   Skills
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: experience.skills
                    .map(
                        (skill) => _ExperienceSkillChip(
                          title: skill,
                        )).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================
// SKILL CHIP
// ==========================================
class _ExperienceSkillChip extends StatelessWidget {
  const _ExperienceSkillChip({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 7
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.25)
        )
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}





class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final String description;
  final List<String> skills;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.skills,
  });
}
