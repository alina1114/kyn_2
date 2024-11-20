import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyn_2/core/common/error_text.dart';
import 'package:kyn_2/core/common/loader.dart';
import 'package:kyn_2/features/auth/controller/auth_controller.dart';
import 'package:kyn_2/features/whatshot/community/controller/community_controller.dart';
import 'package:kyn_2/features/whatshot/post/controller/post_controller.dart';
import 'package:kyn_2/features/whatshot/post/widget/post_card.dart';
import 'package:kyn_2/features/whatshot/post/widget/write_something_widget.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ref.watch(userCommunitiesProvider).when(
        data: (communities) => ref.watch(userPostsProvider(communities)).when(
            data: (posts) {
              return ListView.builder(
                itemCount: posts.length + 1, // Adjust the item count
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const WriteSomethingWidget(); // The widget to write something new
                  } else {
                    final post = posts[index - 1];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: PostCard(post: post),
                    );
                  }
                },
              );
            },
            error: (error, stackTrace) {
              return ErrorText(
                error: error.toString(),
              );
            },
            loading: () => Loader(
                  color: Colors.red,
                )),
        error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
        loading: () => Loader(
              color: Colors.red,
            ));
  }
}
