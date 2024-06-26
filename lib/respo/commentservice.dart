import 'dart:convert';
import 'package:flutter_application_2/models/Comment.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/comments';

  static Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
