import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class BustrexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BustrexAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: preferredSize.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top App Bar Section
          Container(
            color: theme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.person,
                      color: theme.colorScheme.onPrimary, size: 24),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                ),
                Text(
                  "BUSTREX",
                  style: theme.textTheme.displayLarge,
                ),
                Icon(Icons.search,
                    color: theme.colorScheme.onPrimary, size: 24),
              ],
            ),
          ),

          // Movie/Tv Series Navigation Section
          Container(
            width: screenWidth,
            color: theme.colorScheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "MOVIE",
                      style: theme.appBarTheme.titleTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "TV SERIES",
                      style: theme.appBarTheme.titleTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Slightly reduced height
}
