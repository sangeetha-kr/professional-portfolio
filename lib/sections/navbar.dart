import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavBar extends StatefulWidget {
  final Function(String)? onItemSelected; // callback for click
  const NavBar({super.key, this.onItemSelected});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _hoverIndex = -1;
  int _activeIndex = 0;

  final List<String> _items = ["Home", "About", "Services", "Portfolio", "Contact"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: kBgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Portfolio.",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kCyan)),
          Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isHovered = _hoverIndex == index;
              final isActive = _activeIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => _activeIndex = index);
                  if (widget.onItemSelected != null) widget.onItemSelected!(item);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _hoverIndex = index),
                  onExit: (_) => setState(() => _hoverIndex = -1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: isHovered || isActive
                        ? BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: kCyan, width: 2),
                            ),
                          )
                        : null,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isHovered || isActive ? kCyan : Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
