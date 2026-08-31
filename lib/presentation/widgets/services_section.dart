import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lumina/constants/colors.dart';
import 'package:lumina/presentation/widgets/fade_slide_in.dart';
import 'package:lumina/presentation/widgets/hover_card.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({super.key});

  final services = [
    const ServiceModel(
      icon: Icons.phone_android_rounded,
      title: 'Flutter App Development',
      description:
      'Building responsive and modern cross-platform applications '
          'using Flutter and Dart.',
    ),
    const ServiceModel(
      icon: Icons.design_services_outlined,
      title: 'UI Implementation',
      description:
      'Transforming modern designs into clean, responsive, and '
          'user-friendly Flutter interfaces.',
    ),
    const ServiceModel(
      icon: Icons.local_fire_department_rounded,
      title: 'Firebase Integration',
      description:
      'Integrating Firebase services including Authentication, '
          'Cloud Firestore, Storage, and backend services.',
    ),
    const ServiceModel(
      icon: Icons.api_rounded,
      title: 'API Integration',
      description:
      'Connecting Flutter applications with REST APIs and external '
          'services to create dynamic applications.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      key: key,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 100,
        ),
        child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                _ServicesHeader(),
                SizedBox(height: 60,),
                _ServicesGrid(
                  services: services,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION HEADER
// ============================================================

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader();

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
                text: 'My ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'Services',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 650),
          child: Text(
            'I create modern Flutter applications with clean user interfaces '
                'and reliable integrations.',
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
// RESPONSIVE SERVICE GRID
// ============================================================
class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid({super.key, required this.services});

  final List<ServiceModel> services;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossAxisCount = width >= 1100
              ? 4
              : width >= 700
              ? 2
              : 1;
          return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                mainAxisExtent: 300
              ),
              itemBuilder: (context, index) {
                return ServiceCard(
                  service: services[index],
                );
              }
          );
        }
    );
  }
}

// ============================================================
// SERVICE CARD
// ============================================================
class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10
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
              //   Service icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary
                        ]
                    ),
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child: Icon(
                    service.icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                SizedBox(height: 24,),

              //   Service Title
                Text(
                  service.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),


                const SizedBox(height: 14),

                // Service Description
                Expanded(
                  child: Text(
                    service.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.6,
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
// SERVICE MODEL
// ============================================================

class ServiceModel {
  final IconData icon;
  final String title;
  final String description;

  const ServiceModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}
