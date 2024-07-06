import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_2/models/Comment.dart';
import 'package:flutter_application_2/respo/commentservice.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Comment> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      List<Comment> fetchedComments = await ApiService.fetchComments();
      setState(() {
        comments = fetchedComments;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching comments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    color: Colors.lightBlueAccent,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Text(
                              comment.name[0].toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${comment.name}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 5.h),
                                Text('Email: ${comment.email}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    )),
                                SizedBox(height: 10.h),
                                Text(comment.body,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
