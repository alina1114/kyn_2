import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/core/theme/pallete.dart';
import 'package:kyn_2/core/theme/theme.dart';
import 'package:kyn_2/features/auth/controller/auth_controller.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/community/screens/community_screens.dart';
import 'package:kyn_2/features/whatshot/post/controller/post_controller.dart';
import 'package:kyn_2/features/whatshot/post/screens/comments_screen.dart';
import 'package:kyn_2/features/whatshot/user_profile/screens/user_profile.dart';
import 'package:kyn_2/models/post_model.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void upvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void downvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).downvote(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final currentTheme = ref.watch(themeNotifierProvider);

    // Check if there is a link for the image or if the description is provided
    final hasImage = post.link != null && post.link!.isNotEmpty;
    final hasDescription =
        post.description != null && post.description!.isNotEmpty;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: currentTheme.drawerTheme.backgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 5,
                      ).copyWith(right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(onTap: () => {}
                                      /*Navigator.of(context).push(
                                        CommunityScreen.route(post.communityName)),
                                    child: CircleAvatar(
                                      backgroundImage: CachedNetworkImageProvider(
                                        post.communityProfilePic,
                                      ),
                                      radius: 16,
                                    ),
                                    */
                                      ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'r/',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(UserProfileScreen.route(
                                                  post.uid)),
                                          child: Text(
                                            'u/${post.username}',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (post.uid == user.uid)
                                IconButton(
                                  onPressed: () => deletePost(ref, context),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              post.title,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // If the post contains an image
                          if (hasImage)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              child: Image.network(
                                post.link!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          // If the post contains a description
                          if (hasDescription)
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                post.description!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!kIsWeb)
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: isGuest
                                          ? () {}
                                          : () => upvotePost(ref),
                                      icon: Icon(
                                        Icons.keyboard_arrow_up_sharp,
                                        size: 30,
                                        color: post.upvotes.contains(user.uid)
                                            ? AppPallete.redColor
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    IconButton(
                                      onPressed: isGuest
                                          ? () {}
                                          : () => downvotePost(ref),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30,
                                        color: post.downvotes.contains(user.uid)
                                            ? AppPallete.blueColor
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .push(CommentsScreen.route(post.id)),
                                    icon: const Icon(
                                      Icons.comment,
                                    ),
                                  ),
                                  Text(
                                    '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              /*
                              ref
                                  .watch(getCommunityByNameProvider(
                                      post.communityName))
                                  .when(
                                      data: (data) {
                                        if (data.mods.contains(user.uid)) {
                                          return IconButton(
                                            onPressed: () =>
                                                deletePost(ref, context),
                                            icon: const Icon(
                                              Icons.admin_panel_settings,
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                      error: (error, stackTrace) => ErrorText(
                                            error: error.toString(),
                                          ),
                                      loading: () => Loader(
                                            color: Colors.red,
                                          )),
                                          */
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
