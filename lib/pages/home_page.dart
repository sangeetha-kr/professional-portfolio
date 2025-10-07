import 'package:flutter/material.dart';
import '../sections/navbar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/services_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    BuildContext? ctx;
    switch (section) {
      case "Home":
        ctx = _heroKey.currentContext;
        break;
      case "About":
        ctx = _aboutKey.currentContext;
        break;
      case "Services":
        ctx = _servicesKey.currentContext;
        break;
      case "Portfolio":
        ctx = _projectsKey.currentContext;
        break;
      case "Contact":
        ctx = _contactKey.currentContext;
        break;
    }
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(onItemSelected: _scrollToSection),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  KeyedSection(key: _heroKey, child: HeroSection()),
                  KeyedSection(key: _aboutKey, child: AboutSection()),
                  KeyedSection(key: _servicesKey, child: ServicesSection()),
                  KeyedSection(key: _projectsKey, child: SkillsProjectsSection()),
                  KeyedSection(key: _contactKey, child: ContactSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget to assign key to sections
class KeyedSection extends StatelessWidget {
  final Widget child;
  const KeyedSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
