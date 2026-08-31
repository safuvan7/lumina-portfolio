import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onLetsTalk,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  final VoidCallback onViewWork;
  final VoidCallback onLetsTalk;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth < 992;
    return Container(
      key: key,
      constraints: BoxConstraints(minHeight: 800),
      padding: EdgeInsets.only(
        top: 140,
        bottom: 80,
        left: screenWidth > 1200 ? 0 : 20,
        right: screenWidth > 1200 ? 0 : 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: isTablet
              ? Column(
                  children: [
                    HeroGraphic(),
                    SizedBox(height: 50),
                    HeroContent(onPressed: onViewWork, onTap: onLetsTalk),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: HeroContent(
                        onPressed: onViewWork,
                        onTap: onLetsTalk,
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(child: HeroGraphic()),
                  ],
                ),
        ),
      ),
    );
  }
}

class HeroContent extends StatelessWidget {
  const HeroContent({super.key, required this.onPressed, required this.onTap});

  final VoidCallback onPressed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Hello I'm",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 19,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),

        SizedBox(height: 10),

        //    Name with gradient
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Color(0xFFFF7E5F),
                Color(0xFFFEB47B),
                Color(0xFF00C6FF),
                Color(0xFF0072FF),
              ],
            ).createShader(bounds);
          },
          child: Text(
            'Mohamed Safuvan',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 42 : 58,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Flutter & Mobile App Developer',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? 22 : 29,
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: 25),

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 550),
          child: Text(
            "Motivated Flutter Developer with hands-on experience building "
            "cross-platform mobile applications."
            "REST API integration, Firebase, and state "
            "management. Let's build scalable, high-performance, and "
            "user-friendly mobile experiences.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 17,
              height: 1.6,
            ),
          ),
        ),

        SizedBox(height: 35),

        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20,
          runSpacing: 15,
          children: [
            _GradientButton(title: 'View My Work', onPressed: onPressed),
            _SecondaryButton(title: "Let's Talk", onPressed: onTap),
          ],
        ),

        SizedBox(height: 40),

        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20,
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.linkedin,
              url: 'https://linkedin.com/in/mohd-safu',
            ),
            _SocialButton(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/safuvan7',
            ),
            _SocialButton(
              icon: FontAwesomeIcons.message,
              url: 'mailto:mohdsafu26@gmail.com',
            ),
          ],
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(99, 102, 241, 0.4),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.surfaceBorder),
        backgroundColor: AppColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(title),
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({required this.icon, required this.url});

  final FaIconData icon;
  final String url;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  Future<void> _openLink() async {
    final uri = Uri.parse(widget.url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() => _isHovered = true);
      },

      onExit: (_) {
        setState(() => _isHovered = false);
      },

      child: InkWell(
        onTap: _openLink,
        borderRadius: BorderRadius.circular(30),

        child: AnimatedScale(
          scale: _isHovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,

            width: 45,
            height: 45,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              // Glass background
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.14)
                  : AppColors.surface,

              // Glass border
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.55)
                    : AppColors.surfaceBorder,
                width: _isHovered ? 1.5 : 1.0,
              ),

              // Soft glow on hover
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.20),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),

            child: Center(
              child: AnimatedScale(
                scale: _isHovered ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 220),

                child: FaIcon(
                  widget.icon,
                  color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroGraphic extends StatelessWidget {
  const HeroGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children: [
          //   purple gradient blob
          Positioned(
            top: 0,
            left: 0,
            child: _Blob(
              size: 250,
              color: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ),

          //   Secondary blob
          Positioned(
            bottom: 0,
            right: 0,
            child: _Blob(
              size: 250,
              color: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ),

          //   Glass Card
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Transform.rotate(
                angle: 0.08,
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.surfaceBorder),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/my_photo.png'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
