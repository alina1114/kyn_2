import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/features/whatshot/post/screens/add_post_type_screen.dart';

class WriteSomethingWidget extends ConsumerWidget {
  const WriteSomethingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isLightTheme ? Colors.white : Colors.grey[800],
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            AddPostTypeScreen.route(),
          );
        },
        child: Text(
          'Create Post',
          style: TextStyle(
            color: isLightTheme ? Colors.black54 : Colors.grey[300],
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
