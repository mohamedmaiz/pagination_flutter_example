import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
        width: double.infinity,
        child: ClipRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: const Color.fromARGB(255, 20, 27, 82)
                .withOpacity(0.4), // Adjust opacity as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: const Icon(Icons.home, color: Colors.white),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {}),
              ],
            ),
          ),
        )));
  }
}
