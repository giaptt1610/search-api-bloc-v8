import 'dart:convert';

import 'package:http/http.dart' as http;
import 'github_user.dart';

class Api {
  static Future<List<GitHubUser>> search({required String query}) async {
    // https://api.github.com/search/users?q=giaptt
    if (query.isEmpty) {
      return [];
    }
    print('--- api search: $query');
    const baseUrl = 'https://api.github.com/search/users';
    try {
      final response = await http.get(Uri.parse('$baseUrl?q=$query'));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final totalCount = json['total_count'] as int;
      final items = json['items'] as List;
      final users = items.map((e) => GitHubUser.fromMap(e)).toList();

      return users;
    } catch (e) {
      print('-- Exception: ${e.toString()}');
      throw SearchUserException(e.toString());
    }
  }
}

class SearchUserException implements Exception {
  final String msg;
  SearchUserException(this.msg);
}
