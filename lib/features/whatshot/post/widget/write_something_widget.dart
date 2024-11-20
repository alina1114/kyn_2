import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/features/auth/controller/auth_controller.dart';
import 'package:kyn_2/features/whatshot/post/screens/add_post_type_screen.dart';
import 'package:kyn_2/features/whatshot/user_profile/screens/user_profile.dart';

class WriteSomethingWidget extends ConsumerWidget {
  const WriteSomethingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(themeNotifierProvider);
    final user = ref.watch(userProvider)!;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    UserProfileScreen.route(user.uid),
                  ),
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage:
                        CachedNetworkImageProvider(user.profilePic),
                  ),
                ),
                const SizedBox(width: 7.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(AddPostTypeScreen.route('text')),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color:
                              isLightTheme ? Colors.black54 : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        'Write something here...',
                        style: TextStyle(
                          color: isLightTheme ? Colors.black : Colors.grey[400],
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: isLightTheme ? Colors.black54 : Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(AddPostTypeScreen.route('link')),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.link,
                        size: 24.0,
                        color: Colors.pink,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Link',
                        style: TextStyle(
                          color:
                              isLightTheme ? Colors.black54 : Colors.grey[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                  child: VerticalDivider(
                      color: isLightTheme ? Colors.black54 : Colors.grey[300]),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(AddPostTypeScreen.route('image')),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.photo_library,
                        size: 24.0,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        'Photo',
                        style: TextStyle(
                          color:
                              isLightTheme ? Colors.black54 : Colors.grey[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: isLightTheme ? Colors.black54 : Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
