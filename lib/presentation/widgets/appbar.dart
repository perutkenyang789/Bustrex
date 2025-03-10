import 'package:flutter/material.dart';

import '../screens/profile_screen.dart';

class BustrexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BustrexAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                Text(
                  "BUSTREX",
                  style: theme.textTheme.displayLarge,
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
