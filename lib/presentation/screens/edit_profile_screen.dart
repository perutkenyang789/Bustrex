import 'package:flutter/material.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/profile_model.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  Profile profile = ProfileRepository.defaultProfile;
  late TextEditingController _nameController;
  late TextEditingController _nicknameController;
  late TextEditingController _bioController;
  late TextEditingController _hobbyController;
  late TextEditingController _instagramUsernameController;
  late TextEditingController _twitterUsernameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _nicknameController = TextEditingController(text: widget.profile.nickname);
    _bioController = TextEditingController(text: widget.profile.bio);
    _hobbyController = TextEditingController(text: widget.profile.hobby);
    _instagramUsernameController =
        TextEditingController(text: widget.profile.instagramUsername);
    _twitterUsernameController =
        TextEditingController(text: widget.profile.twitterUsername);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _bioController.dispose();
    _hobbyController.dispose();
    _instagramUsernameController.dispose();
    _twitterUsernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final bool isWideScreen = screenSize.width > 600;

    // Calculate responsive sizes
    final double horizontalPadding =
        isWideScreen ? screenSize.width * 0.15 : 24.0;
    const double maxContentWidth = 800.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),

                  // Name Input
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person,
                          color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      profile = profile.copy(name: value); // Removed setState
                    },
                  ),

                  const SizedBox(height: 16),

                  // Nickname Input
                  TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      labelText: "Nickname",
                      prefixIcon: Icon(Icons.alternate_email,
                          color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      profile = profile.copy(nickname: value);
                    },
                  ),

                  const SizedBox(height: 16),

                  // Bio Input
                  TextField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: "Bio",
                      hintText: "Tell us about yourself",
                      prefixIcon:
                          Icon(Icons.info, color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      profile = profile.copy(bio: value);
                    },
                    maxLines: 3,
                  ),

                  const SizedBox(height: 32),

                  TextField(
                    controller: _hobbyController,
                    decoration: InputDecoration(
                      labelText: "Hobby",
                      hintText: "What do you enjoy doing?",
                      prefixIcon: Icon(Icons.sports_esports,
                          color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        profile = profile.copy(hobby: value);
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Instagram Username Input
                  TextField(
                    controller: _instagramUsernameController,
                    decoration: InputDecoration(
                      labelText: "Instagram Username",
                      hintText: "Your Instagram username",
                      prefixIcon: Icon(Icons.camera_alt,
                          color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      profile = profile.copy(instagramUsername: value);
                    },
                  ),

                  const SizedBox(height: 16),

                  // Twitter Username Input
                  TextField(
                    controller: _twitterUsernameController,
                    decoration: InputDecoration(
                      labelText: "Twitter Username",
                      hintText: "Your Twitter username",
                      prefixIcon:
                          Icon(Icons.chat, color: theme.colorScheme.secondary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: theme.colorScheme.secondary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      profile = profile.copy(twitterUsername: value);
                    },
                  ),

                  const SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Name cannot be empty!")),
                          );
                          return;
                        }
                        ProfileRepository.setProfile(profile);
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
