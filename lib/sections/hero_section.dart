import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  final List<double> _delays = [0, 0.2, 0.4, 0.6];
  bool _hoveringGit = false;
  bool _hoveringLinkedIn = false;
  bool _hoveringInsta = false;
  bool _hoveringButton = false;

  @override
  void initState() {
    super.initState();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: LayoutBuilder(builder: (context, constraints) {
        return Flex(
          direction:
              constraints.maxWidth < 800 ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TEXT & BUTTONS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _animatedText("Hello, It's Me", 24, kTextLight, 0),
                const SizedBox(height: 10),
                _animatedText("SANGEETHA K R", 42, kTextWhite, 1,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 8),
                _animatedText("And I'm a Flutter Developer", 24, kCyan, 2,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 16),
                _animatedText(
                  "I build modern web & mobile apps using Flutter with a focus on clean UI, performance, and pixel-perfect design.",
                  16,
                  kTextLight,
                  3,
                  maxWidth: 400,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _socialIcon(FontAwesomeIcons.github, kCyan,
                        "https://github.com/sangeetha-kr", _hoveringGit, (h) {
                      setState(() => _hoveringGit = h);
                    }),
                    _socialIcon(FontAwesomeIcons.linkedin, kCyan,
                        "https://www.linkedin.com/in/sangeetha-k-r/",
                        _hoveringLinkedIn, (h) {
                      setState(() => _hoveringLinkedIn = h);
                    }),
                    _socialIcon(FontAwesomeIcons.instagram, kCyan,
                        "https://www.instagram.com/sangeethhaaa/?hl=en",
                        _hoveringInsta, (h) {
                      setState(() => _hoveringInsta = h);
                    }),
                  ],
                ),
                const SizedBox(height: 30),
                MouseRegion(
                  onEnter: (_) => setState(() => _hoveringButton = true),
                  onExit: (_) => setState(() => _hoveringButton = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: _hoveringButton
                        ? (Matrix4.identity()..scale(1.05))
                        : Matrix4.identity(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kCyan,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: kCyan,
                        elevation: 12,
                      ),
                      onPressed: () => launchUrl(Uri.parse("lib/assets/Resume_portfolio.pdf")),
                      child: const Text("Download CV"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // PROFILE IMAGE
            ScaleTransition(
              scale: _pulse,
              child: RotationTransition(
                turns: Tween(begin: -0.01, end: 0.01)
                    .animate(_pulseController), // tiny sway
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: kCyan.withOpacity(0.8),
                          blurRadius: 50,
                          spreadRadius: 10)
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/profile_pic.png',
                      width: 280,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _animatedText(String text, double fontSize, Color color, int index,
      {FontWeight fontWeight = FontWeight.normal, double? maxWidth}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      //delay: Duration(milliseconds: (index * 200)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(-50 * (1 - value), 0),
            child: Container(
              width: maxWidth,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        color: kCyan.withOpacity(0.6),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
  

  Widget _socialIcon(IconData icon, Color color, String url, bool hovering,
      Function(bool) onHover) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        transform: hovering
            ? (Matrix4.identity()..scale(1.2))
            : Matrix4.identity(),
        child: IconButton(
          icon: FaIcon(icon, color: color),
          onPressed: () => launchUrl(Uri.parse(url)),
        ),
      ),
    );
  }
}
