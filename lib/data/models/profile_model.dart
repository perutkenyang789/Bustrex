class Profile {
  final String name;
  final String nickname;
  final String bio;
  final String hobby;
  final String instagramUsername;
  final String twitterUsername;

  const Profile({
    required this.name,
    required this.nickname,
    required this.bio,
    required this.hobby,
    required this.instagramUsername,
    required this.twitterUsername,
  });

  Profile copy({
    String? name,
    String? nickname,
    String? bio,
    String? hobby,
    String? instagramUsername,
    String? twitterUsername,
  }) {
    return Profile(
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      hobby: hobby ?? this.hobby,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      twitterUsername: twitterUsername ?? this.twitterUsername,
    );
  }

  static Profile fromJson(Map<String, dynamic> data) {
    return Profile(
      name: data['name'] ?? 'Bustrex User',
      nickname: data['nickname'] ?? 'movieJunkie',
      bio: data['bio'] ?? '',
      hobby: data['hobby'] ?? 'Bustrex and Chill',
      instagramUsername: data['instagramUsername'] ?? '',
      twitterUsername: data['twitterUsername'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nickname': nickname,
      'bio': bio,
      'hobby': hobby,
      'instagramUsername': instagramUsername,
      'twitterUsername': twitterUsername,
    };
  }
}
