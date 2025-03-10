import 'package:flutter/material.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/profile_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Profile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    setState(() {
      _profileFuture = ProfileRepository.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final bool isWideScreen = screenSize.width > 600;

    final double horizontalPadding =
        isWideScreen ? screenSize.width * 0.15 : 24.0;
    const double maxContentWidth = 800.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile",
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Edit Profile Button moved to app bar
          FutureBuilder<Profile>(
            future: _profileFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox.shrink();
              }

              Profile profile = snapshot.data!;
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(profile: profile),
                    ),
                  );

                  // Reload profile if editing was successful
                  if (result == true) {
                    _loadProfile();
                  }
                },
                tooltip: "Edit Profile",
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Profile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.secondary,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load profile",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                "No profile data available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          Profile profile = snapshot.data!;

          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxContentWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),

                      // User info
                      Text(
                        profile.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: isWideScreen ? 36 : 28,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "@${profile.nickname}",
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: isWideScreen ? 18 : 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 16),

                      // Bio Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          profile.bio.isEmpty
                              ? "Add a bio to tell people about yourself!"
                              : profile.bio,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: profile.bio.isEmpty
                                ? FontStyle.italic
                                : FontStyle.normal,
                            color: profile.bio.isEmpty
                                ? Colors.grey
                                : theme.textTheme.bodyLarge?.color,
                            fontSize: isWideScreen ? 18 : null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Hobby Section
                      Text(
                        "Hobby: ${profile.hobby}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: isWideScreen ? 18 : null,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Social Media Section
                      if (profile.instagramUsername.isNotEmpty ||
                          profile.twitterUsername.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (profile.instagramUsername.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const ImageIcon(
                                        AssetImage(
                                            "assets/images/instagram-icon.png"),
                                        size: 14,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        profile.instagramUsername,
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(width: 8),
                              if (profile.twitterUsername.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const ImageIcon(
                                        AssetImage("assets/images/x-icon.png"),
                                        size: 14,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        profile.twitterUsername,
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
