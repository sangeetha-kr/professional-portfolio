import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": "Mobile Apps",
        "desc": "Develop Android & iOS apps using Flutter for smooth performance"
      },
      {
        "title": "Web Development",
        "desc": "Build responsive web apps with Flutter Web and modern UI"
      },
      {
        "title": "UI/UX Design",
        "desc": "Design clean, modern interfaces with Figma & Flutter widgets"
      },
      {
        "title": "API Integration",
        "desc": "Integrate REST APIs, Firebase, and third-party services"
      },
      {
        "title": "State Management",
        "desc": "Implement Provider, Riverpod, or Bloc for efficient app state"
      },
      {
        "title": "Performance Optimization",
        "desc": "Ensure smooth animations, fast load times, and low memory usage"
      },
    ];

    return Container(
      color: kBgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const Text(
            "Our Services",
            style: TextStyle(
              color: kCyan,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: kCyan, blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(services.length, (i) {
              final srv = services[i];
              return _AnimatedServiceCard(
                title: srv['title']!,
                description: srv['desc']!,
                delay: i * 200,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _AnimatedServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final int delay;

  const _AnimatedServiceCard({
    required this.title,
    required this.description,
    required this.delay,
  });

  @override
  State<_AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard> {
  bool _hovering = false;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 300, // fixed width for all cards
          height: 180, // fixed height for uniformity
          padding: const EdgeInsets.all(20),
          transform: _hovering ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: kCardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: kCyan.withOpacity(_hovering ? 0.4 : 0.2),
                blurRadius: _hovering ? 25 : 15,
                spreadRadius: _hovering ? 5 : 2,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: kCyan,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: kCyan, blurRadius: 8),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kTextLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
