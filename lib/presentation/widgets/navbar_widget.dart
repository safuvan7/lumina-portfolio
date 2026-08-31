import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class PortfolioNavbar extends StatefulWidget {
  const PortfolioNavbar({
    super.key,
    required this.onMenuTap,
  });

  final ValueChanged<String> onMenuTap;

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.90),
        border: const Border(
          bottom: BorderSide(color: AppColors.surfaceBorder),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              const _PortfolioLogo(),

              // Desktop Navigation
              if (!isMobile)
                Row(
                  children: [
                    _NavItem(
                      title: 'Home',
                      onTap: () => widget.onMenuTap('home'),
                    ),
                    _NavItem(
                      title: 'Skills',
                      onTap: () => widget.onMenuTap('skills'),
                    ),
                    _NavItem(
                      title: 'Experience',
                      onTap: () => widget.onMenuTap('experience'),
                    ),
                    _NavItem(
                      title: 'Projects',
                      onTap: () => widget.onMenuTap('projects'),
                    ),
                    _NavItem(
                      title: 'Services',
                      onTap: () => widget.onMenuTap('services'),
                    ),
                    const SizedBox(width: 10),
                    _ContactButton(
                      onTap: () => widget.onMenuTap('contact'),
                    ),
                  ],
                ),

              // Mobile Menu Button
              if (isMobile)
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.textPrimary,
                        size: 30,
                      ),
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

class _PortfolioLogo extends StatefulWidget {
  const _PortfolioLogo();

  @override
  State<_PortfolioLogo> createState() => _PortfolioLogoState();
}

class _PortfolioLogoState extends State<_PortfolioLogo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'MS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: '.',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          style: TextStyle(
            color: _isHovered
                ? AppColors.primary
                : AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  const _ContactButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: OutlinedButton(
          onPressed: widget.onTap,
          style: OutlinedButton.styleFrom(
            foregroundColor: _isHovered
                ? Colors.white
                : AppColors.primary,
            side: BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Contact Me',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}