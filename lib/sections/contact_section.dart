import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  // open links
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactItems = [
      {
        "icon": Icons.email_outlined,
        "label": "Email",
        "value": "sangeethakr.39bw@gmail.com",
        "url": "mailto:sangeethakr.39bw@gmail.com"
      },
      {
        "icon": Icons.phone_android,
        "label": "Phone",
        "value": "+91 9110894774",
        "url": "tel:+919110894774"
      },
      {
        "icon": Icons.location_on_outlined,
        "label": "Location",
        "value": "Bengaluru, Karnataka, India",
        "url": "https://www.google.com/maps/place/Bengaluru"
      },
      {
        "icon": Icons.link,
        "label": "LinkedIn",
        "value": "linkedin.com/in/sangeetha-kr",
        "url": "https://www.linkedin.com/in/sangeetha-kr"
      },
      {
        "icon": Icons.code,
        "label": "GitHub",
        "value": "github.com/sangeetha-kr",
        "url": "https://github.com/sangeetha-kr"
      },
    ];

    return Container(
      color: kBgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Contact Me!",
            style: TextStyle(
                color: kCyan, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 30,
            children: contactItems.map((item) {
              return _ContactCard(
                icon: item["icon"] as IconData,
                label: item["label"] as String,
                value: item["value"] as String,
                onTap: () => _launchUrl(item["url"] as String),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
          const Text(
            "© 2025 Sangeetha K R | Built with Flutter 💙",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          width: 260,
          decoration: BoxDecoration(
            color: _hovering ? kCyan.withOpacity(0.15) : kCardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: kCyan.withOpacity(_hovering ? 0.3 : 0.1),
                blurRadius: _hovering ? 20 : 8,
              )
            ],
            border: Border.all(
              color: _hovering ? kCyan : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: kCyan, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.label,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: TextStyle(
                        color: _hovering ? kCyan : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
