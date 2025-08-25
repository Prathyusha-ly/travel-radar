class WPUser {
  final int id;
  final String name;
  final String slug;
  final String? email;
  final String? avatarUrl;

  WPUser({
    required this.id,
    required this.name,
    required this.slug,
    this.email,
    this.avatarUrl,
  });

  factory WPUser.fromJson(Map<String, dynamic> json) {
    final avatars = (json['avatar_urls'] ?? {}) as Map<String, dynamic>;
    return WPUser(
      id: json['id'] ?? 0,
      name: (json['name'] ?? '').toString(),
      slug: (json['slug'] ?? '').toString(),
      email: (json['email'])?.toString(),
      avatarUrl: avatars['96']?.toString() ?? avatars['48']?.toString(),
    );
    }
}
