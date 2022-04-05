class GitHubUser {
  final String username;
  final String avatar;
  final String url;

  GitHubUser({this.username = '', this.avatar = '', this.url = ''});

  GitHubUser.fromMap(Map<String, dynamic> map)
      : username = map['login'],
        avatar = map['avatar_url'],
        url = map['html_url'];
}
