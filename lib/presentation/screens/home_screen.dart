import 'package:flutter/material.dart';
import 'package:lumina/presentation/widgets/contact_section.dart';
import 'package:lumina/presentation/widgets/project_section.dart';
import 'package:lumina/presentation/widgets/scroll_reveal.dart';
import 'package:lumina/presentation/widgets/services_section.dart';
import 'package:lumina/presentation/widgets/skills_section.dart';
import '../../constants/colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar_widget.dart';
import 'package:lumina/presentation/widgets/experience_section.dart';
import 'package:lumina/presentation/widgets/portfolio_footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // GlobalKeys for every portfolio section
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Smooth scroll to selected section
  void _scrollToSection(String section) {
    final Map<String, GlobalKey> sectionKeys = {
      'home': _homeKey,
      'skills': _skillsKey,
      'experience': _experienceKey,
      'projects': _projectsKey,
      'services': _servicesKey,
      'contact': _contactKey,
    };

    final key = sectionKeys[section];

    if (key == null) return;

    final context = key.currentContext;

    if (context == null) {
      debugPrint('Section not found: $section');
      return;
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    final position = renderBox.localToGlobal(Offset.zero);

    final scrollOffset = _scrollController.offset + position.dy - 80;

    _scrollController.animateTo(
      scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Mobile Navigation Drawer
      endDrawer: _PortfolioDrawer(onMenuTap: _scrollToSection),

      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/images/bg_hero.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              color: AppColors.background.withValues(alpha: 0.80),
            ),
          ),

          // Scrollable Portfolio Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  key: _homeKey,
                  child: HeroSection(
                    onViewWork: () => _scrollToSection('projects'),
                    onLetsTalk: () => _scrollToSection('contact'),
                  ),
                ),

                Container(key: _skillsKey, child: const SkillsSection()),

                Container(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),

                Container(key: _projectsKey, child: ProjectSection()),

                Container(key: _servicesKey, child: ServicesSection()),

                Container(key: _contactKey, child: const ContactSection()),

                const PortfolioFooter(),
              ],
            ),
          ),

          // Fixed Navbar
          PortfolioNavbar(onMenuTap: _scrollToSection),
        ],
      ),
    );
  }
}

// Mobile Drawer
class _PortfolioDrawer extends StatelessWidget {
  const _PortfolioDrawer({required this.onMenuTap});

  final ValueChanged<String> onMenuTap;

  void _handleTap(BuildContext context, String section) {
    // Close drawer
    Navigator.pop(context);

    // Small delay allows drawer closing animation
    Future.delayed(const Duration(milliseconds: 250), () {
      if (context.mounted) {
        onMenuTap(section);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      width: 280,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header
              const Row(
                children: [
                  Text(
                    'MS',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              _DrawerItem(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: () => _handleTap(context, 'home'),
              ),
              _DrawerItem(
                icon: Icons.code_outlined,
                title: 'Skills',
                onTap: () => _handleTap(context, 'skills'),
              ),
              _DrawerItem(
                icon: Icons.work_outline,
                title: 'Experience',
                onTap: () => _handleTap(context, 'experience'),
              ),
              _DrawerItem(
                icon: Icons.folder_outlined,
                title: 'Projects',
                onTap: () => _handleTap(context, 'projects'),
              ),
              _DrawerItem(
                icon: Icons.design_services_outlined,
                title: 'Services',
                onTap: () => _handleTap(context, 'services'),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _handleTap(context, 'contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Contact Me'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
