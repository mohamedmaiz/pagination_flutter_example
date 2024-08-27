import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 80.0,
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 20, 27, 82).withOpacity(0.3),
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        bool isCollapsed = settings == null
            ? false
            : settings.minExtent == settings.currentExtent;
        return FlexibleSpaceBar(
            expandedTitleScale: 1.5,
            title: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width:
                          isCollapsed ? 120 : MediaQuery.of(context).size.width,
                      child: const Text('Suggestion',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
            )));
      }),
    );
  }
}
