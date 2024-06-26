import 'dart:convert';
import 'package:flutter_application_2/models/Comment.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/comments';

  static Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Comment> comments = jsonList.map((json) => Comment.fromJson(json)).toList();

      // Check if email masking is enabled in Remote Config
      bool maskEmail = await _getMaskEmailConfig();

      // Mask emails if enabled
      if (maskEmail) {
        for (Comment comment in comments) {
          comment.email = _maskEmail(comment.email);
        }
      }

      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  static Future<bool> _getMaskEmailConfig() async {
    try {
      // Fetch remote config
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      
      // Get boolean value from remote config
      return FirebaseRemoteConfig.instance.getBool('mask_email');
    } catch (e) {
      print('Error fetching Remote Config: $e');
      return false; // Default to false if there's an error
    }
  }

  static String _maskEmail(String email) {
    if (email != null || email.isEmpty) return '';

    int atIndex = email.indexOf('@');
    if (atIndex > 0) {
      String masked = email.substring(0, 3) + '*' * (atIndex - 3) + email.substring(atIndex);
      return masked;
    } else {
      return email;
    }
  }
}
