import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141414),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/profile_pic.png',
              width: 250,
              height: 250,
            ),
          ),
          const SizedBox(width: 40),
          SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "About Me",
                  style: TextStyle(
                    color: kCyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Flutter Developer!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "I'm passionate about crafting beautiful mobile and web applications with Flutter. I love solving problems and bringing creative ideas to life with clean UI and smooth UX.",
                  style: TextStyle(color: kTextLight, fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // your action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kCyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                  ),
                  child: const Text("Read More"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
