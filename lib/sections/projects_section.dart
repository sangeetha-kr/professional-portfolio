import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SkillsProjectsSection extends StatelessWidget {
  const SkillsProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
final skills = [
  {"name": "Flutter", "level": 0.9, "icon": "lib/assets/flutter.png"},
  {"name": "Dart", "level": 0.85, "icon": "lib/assets/dart.png"},
  {"name": "Firebase", "level": 0.8, "icon": "lib/assets/firebase.png"},
  {"name": "Provider (State Management)", "level": 0.8, "icon": "lib/assets/flutter.png"}, // reuse Flutter icon
  {"name": "REST API Integration", "level": 0.85, "icon": "lib/assets/api.jpg"},
  {"name": "UI/UX Design (Figma)", "level": 0.75, "icon": "lib/assets/figma.png"},
  {"name": "SQL / MySQL", "level": 0.7, "icon": "lib/assets/mysql.png"},
  {"name": "GitHub", "level": 0.85, "icon": "lib/assets/github.png"},
  {"name": "Postman / API Testing", "level": 0.8, "icon": "lib/assets/postman.jpeg"}, // svg will need flutter_svg package
  {"name": "Android Development", "level": 0.75, "icon": "lib/assets/android.png"},
  {"name": "Git Basics", "level": 0.8, "icon": "lib/assets/git.png"},
];


    final projects = [
      {
        "title": "Dynamic Form Builder",
        "desc": "Flutter web app with Provider and JSON persistence.",
        "img": "lib/assets/quick_hire.jpg"
      },
      {
        "title": "One-Junction Delivery",
        "desc": "Multi-app ecosystem with Razorpay & real-time tracking.",
        "img": "lib/assets/One_logo.jpg"
      },
      {
        "title": "QuickHire App",
        "desc": "Job portal like Naukri with Firebase backend.",
        "img": "lib/assets/quick_hire.jpg"
      },
    ];

    return Container(
      color: const Color(0xFF141414),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Skills Section ---
          const Text(
            "Skills",
            style: TextStyle(
              color: kCyan,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: skills
                .map((s) => _CircularSkillCard(
                      name: s['name'] as String,
                      level: s['level'] as double,
                      icon: s['icon'] as String,
                    ))
                .toList(),
          ),
          const SizedBox(height: 60),

          // --- Projects Section ---
          const Text(
            "Featured Projects",
            style: TextStyle(
              color: kCyan,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: projects
                .map((p) => _HoverProjectCard(
                      title: p['title']!,
                      desc: p['desc']!,
                      img: p['img']!,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// --- Circular Skill Card with icon + animated progress ---
class _CircularSkillCard extends StatefulWidget {
  final String name;
  final double level;
  final String icon;
  const _CircularSkillCard(
      {required this.name, required this.level, required this.icon});

  @override
  State<_CircularSkillCard> createState() => _CircularSkillCardState();
}

class _CircularSkillCardState extends State<_CircularSkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation =
        Tween<double>(begin: 0, end: widget.level).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            _hovering ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        color: kCyan,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        widget.icon,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 120,
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kTextLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- Project Card with hover overlay ---
class _HoverProjectCard extends StatefulWidget {
  final String img;
  final String title;
  final String desc;
  const _HoverProjectCard(
      {required this.img, required this.title, required this.desc});

  @override
  State<_HoverProjectCard> createState() => _HoverProjectCardState();
}

class _HoverProjectCardState extends State<_HoverProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
            _hovering ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: kCyan.withOpacity(_hovering ? 0.4 : 0.2),
              blurRadius: _hovering ? 25 : 15,
              spreadRadius: _hovering ? 5 : 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.img,
                width: 300,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: _hovering
                  ? Colors.black.withOpacity(0.6)
                  : Colors.transparent,
              width: 300,
              height: 180,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: _hovering
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.desc,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
