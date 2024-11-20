import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:kyn_2/core/constants/constants.dart';
import 'package:kyn_2/models/post_model.dart'; // Ensure this import is correct

class PostView extends StatelessWidget {
  final Post post;

  const PostView({super.key, required this.post});

  static Route route(Post post) {
    return MaterialPageRoute(
      builder: (context) => PostView(post: post), // Corrected class name here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: ListView(
        children: [
          // Display the image at the top
          CachedNetworkImage(
            imageUrl: post.link ?? Constants.bannerDefault,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 16),
          // Display the title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.title,
              style: GoogleFonts.noticiaText(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Display the poster's name if available
          if (post.username != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'By ${post.username}',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Display the categories (topics)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(post.category.name),
          ),
          const SizedBox(height: 16),
          // Display the content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.description ?? "",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Display the last updated date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Updated at: ${DateFormat('yyyy-MM-dd HH:mm').format(post.createdAt)}',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
