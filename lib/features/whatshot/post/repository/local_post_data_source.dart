
/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapp/models/post_model.dart';

final boxProvider = FutureProvider<Box<Map<String, dynamic>>>((ref) async {
  await Hive.initFlutter(); // Initialize Hive for Flutter

  // Get the application documents directory
  final appDocumentDir = await getApplicationDocumentsDirectory();

  // Open the Hive box using the correct directory path
  return Hive.openBox<Map<String, dynamic>>('postsBox',
      path: appDocumentDir.path);
});

final localDataSourceProvider = Provider<WhatshotLocalDataSource>((ref) {
  final asyncValue = ref.watch(boxProvider); // Watch the boxProvider

  // Check if the box is loaded and handle the AsyncValue
  return asyncValue.when(
    data: (box) => WhatshotLocalDataSource(box),
    loading: () => throw Exception(
        'Box<Post> is still loading...'), // Handle loading state if needed
    error: (error, stackTrace) => throw Exception(
        'Failed to open Box<Post>: $error'), // Handle error state if needed
  );
});

class WhatshotLocalDataSource {
  final Box box;

  WhatshotLocalDataSource(this.box);

  List<Post> loadPosts() {
    List<Post> posts = [];
    for (int i = 0; i < box.length; i++) {
      final postMap =
          box.get(i.toString()) as Map<String, dynamic>?; // Load as Map
      if (postMap != null) {
        posts.add(Post.fromMap(postMap)); // Convert to Post
      }
    }
 8   return posts;
  }

  void uploadLocalPosts({required List<Post> posts}) {
    box.clear(); // Clear existing data
    for (int i = 0; i < posts.length; i++) {
      // Store each post as a Map<String, dynamic>
      box.put(i.toString(), posts[i].toMap());
    }
  }
}
*/
